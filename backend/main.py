from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import asyncio
import threading
import time
from datetime import datetime

from scanner.rvol_scanner import RVOLScanner

app = FastAPI(
    title="Project Kite-X API",
    description="Backend API for Zerodha Kite Clone with RVOL Scanner",
    version="1.0.0"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify exact origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Global scanner instance
scanner = RVOLScanner()

# Store latest scan results
latest_scan_results = []
last_scan_time = None
scan_lock = threading.Lock()

class StockData(BaseModel):
    symbol: str
    current_price: float
    price_change: float
    rvol: float
    volume: int
    is_gem: bool
    high: float
    low: float
    open: float

class ScanResult(BaseModel):
    timestamp: str
    total_stocks: int
    gem_count: int
    data: List[StockData]

class GemCandidate(BaseModel):
    symbol: str
    current_price: float
    price_change: float
    rvol: float
    volume: int
    is_gem: bool
    high: float
    low: float
    open: float

@app.get("/")
def read_root():
    return {"message": "Project Kite-X API is running!"}

@app.get("/stocks", response_model=List[StockData])
async def get_all_stocks():
    """Get all scanned stock data"""
    global latest_scan_results
    with scan_lock:
        if not latest_scan_results:
            # If no cached results, perform scan
            latest_scan_results = await scanner.scan_all_stocks()
        return latest_scan_results

@app.get("/gems", response_model=List[GemCandidate])
async def get_gem_candidates():
    """Get only gem candidates (stocks meeting RVOL criteria)"""
    global latest_scan_results
    with scan_lock:
        if not latest_scan_results:
            # If no cached results, perform scan
            latest_scan_results = await scanner.scan_all_stocks()
    
    gems = [stock for stock in latest_scan_results if stock['is_gem']]
    return gems

@app.get("/scan", response_model=ScanResult)
async def trigger_scan():
    """Trigger a fresh scan of all stocks"""
    global latest_scan_results, last_scan_time
    print("Manual scan triggered...")
    
    start_time = time.time()
    results = await scanner.scan_all_stocks()
    
    gems = [stock for stock in results if stock['is_gem']]
    
    with scan_lock:
        latest_scan_results = results
        last_scan_time = datetime.now().isoformat()
    
    scan_duration = round(time.time() - start_time, 2)
    
    print(f"Scan completed in {scan_duration}s. Found {len(gems)} gems.")
    
    return ScanResult(
        timestamp=last_scan_time,
        total_stocks=len(results),
        gem_count=len(gems),
        data=[StockData(**item) for item in results]
    )

@app.get("/stock/{symbol}", response_model=StockData)
async def get_stock_detail(symbol: str):
    """Get details for a specific stock"""
    global latest_scan_results
    with scan_lock:
        if not latest_scan_results:
            # If no cached results, perform scan
            latest_scan_results = await scanner.scan_all_stocks()
    
    # Find the specific stock
    for stock in latest_scan_results:
        if stock['symbol'].lower() == symbol.lower():
            return StockData(**stock)
    
    raise HTTPException(status_code=404, detail=f"Stock {symbol} not found")

# Background scheduler thread
def schedule_scans():
    """Run scans periodically every 5 minutes during market hours"""
    while True:
        # Check if it's market hours (9:15 AM to 3:30 PM IST)
        now = datetime.now()
        # Convert to IST (UTC+5:30) for comparison
        ist_hour = (now.hour + 5) % 24  # Rough conversion, simplified
        ist_minute = now.minute + 30
        if ist_minute >= 60:
            ist_hour = (ist_hour + 1) % 24
            ist_minute -= 60
            
        # Market hours: 9:15 AM to 3:30 PM IST
        is_market_open = (
            (ist_hour == 9 and ist_minute >= 15) or  # After 9:15 AM
            (10 <= ist_hour <= 14) or                 # 10 AM to 2 PM
            (ist_hour == 15 and ist_minute <= 30)      # Before 3:30 PM
        )
        
        if is_market_open:
            print("Market is open, running scheduled scan...")
            
            # Run the async scan in a new event loop
            async def run_scan():
                global latest_scan_results, last_scan_time
                results = await scanner.scan_all_stocks()
                gems = [stock for stock in results if stock['is_gem']]
                
                with scan_lock:
                    latest_scan_results = results
                    last_scan_time = datetime.now().isoformat()
                
                print(f"Scheduled scan completed. Found {len(gems)} gems.")
            
            # Create a new event loop for the scan
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            loop.run_until_complete(run_scan())
            loop.close()
        else:
            print("Market is closed, skipping scan...")
        
        # Wait 5 minutes before next check
        time.sleep(5 * 60)

# Start background scheduler in a separate thread
scheduler_thread = threading.Thread(target=schedule_scans, daemon=True)
scheduler_thread.start()

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)