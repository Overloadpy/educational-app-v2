import yfinance as yf
import pandas as pd
import numpy as np
from datetime import datetime, timedelta
from typing import List, Dict, Tuple
import asyncio

class RVOLScanner:
    """
    Relative Volume (RVOL) Scanner for Indian Stock Market
    Formula: RVOL = (Average Volume of Last 10 Days) / (Average Volume of Last 91 Days)
    Signal Condition: RVOL > 2.0 AND Price Change between -1% and +2%
    """
    
    def __init__(self):
        # Top 50 NSE stocks by market cap
        self.nse_stocks = [
            'RELIANCE.NS', 'TCS.NS', 'HDFCBANK.NS', 'INFY.NS', 'ICICIBANK.NS',
            'HINDUNILVR.NS', 'SBIN.NS', 'BHARTIARTL.NS', 'ITC.NS', 'KOTAKBANK.NS',
            'LT.NS', 'ASIANPAINT.NS', 'MARUTI.NS', 'AXISBANK.NS', 'SUNPHARMA.NS',
            'TATAMOTORS.NS', 'TATASTEEL.NS', 'NESTLEIND.NS', 'ONGC.NS', 'POWERGRID.NS',
            'ULTRACEMCO.NS', 'M&M.NS', 'NTPC.NS', 'BAJFINANCE.NS', 'WIPRO.NS',
            'GRASIM.NS', 'ADANIPORTS.NS', 'INDUSINDBK.NS', 'JSWSTEEL.NS', 'HCLTECH.NS',
            'TITAN.NS', 'BAJAJFINSV.NS', 'BRITANNIA.NS', 'APOLLOHOSP.NS', 'COALINDIA.NS',
            'TECHM.NS', 'DRREDDY.NS', 'CIPLA.NS', 'HEROMOTOCO.NS', 'EICHERMOT.NS',
            'GODREJCON.NS', 'SHREECEM.NS', 'BPCL.NS', 'IOC.NS', 'VEDL.NS',
            'UPL.NS', 'HDFC.NS', 'DIVISLAB.NS', 'TATACONSUM.NS', 'BERGEPAINT.NS'
        ]
        
    async def fetch_stock_data(self, symbol: str) -> pd.DataFrame:
        """Fetch stock data for a given symbol"""
        try:
            stock = yf.Ticker(symbol)
            # Get 100 days of data to calculate both 10-day and 91-day averages
            hist = stock.history(period="100d")
            return hist
        except Exception as e:
            print(f"Error fetching data for {symbol}: {e}")
            return pd.DataFrame()
    
    def calculate_rvol(self, df: pd.DataFrame) -> float:
        """Calculate Relative Volume (RVOL) for a stock"""
        if len(df) < 91:
            return 0.0
        
        # Get the last 10 days volume
        last_10_days_vol = df['Volume'].tail(10).mean()
        
        # Get the last 91 days volume (excluding today to avoid forward bias)
        last_91_days_vol = df['Volume'].tail(91).mean()
        
        # Calculate RVOL
        if last_91_days_vol == 0:
            return 0.0
            
        rvol = last_10_days_vol / last_91_days_vol
        return round(rvol, 2)
    
    def calculate_price_change(self, df: pd.DataFrame) -> float:
        """Calculate percentage price change over the last day"""
        if len(df) < 2:
            return 0.0
        
        prev_close = df['Close'].iloc[-2]
        current_close = df['Close'].iloc[-1]
        
        price_change = ((current_close - prev_close) / prev_close) * 100
        return round(price_change, 2)
    
    def is_gem_candidate(self, rvol: float, price_change: float) -> bool:
        """Check if stock meets gem finder criteria"""
        return rvol > 2.0 and -1.0 <= price_change <= 2.0
    
    async def scan_single_stock(self, symbol: str) -> Dict:
        """Scan a single stock for RVOL and other metrics"""
        df = await self.fetch_stock_data(symbol)
        
        if df.empty:
            return {
                'symbol': symbol,
                'error': 'No data available'
            }
        
        rvol = self.calculate_rvol(df)
        price_change = self.calculate_price_change(df)
        is_gem = self.is_gem_candidate(rvol, price_change)
        
        # Get current price
        current_price = df['Close'].iloc[-1]
        
        return {
            'symbol': symbol,
            'current_price': round(current_price, 2),
            'price_change': price_change,
            'rvol': rvol,
            'volume': int(df['Volume'].iloc[-1]),
            'is_gem': is_gem,
            'high': round(df['High'].iloc[-1], 2),
            'low': round(df['Low'].iloc[-1], 2),
            'open': round(df['Open'].iloc[-1], 2)
        }
    
    async def scan_all_stocks(self) -> List[Dict]:
        """Scan all NSE stocks and return results sorted by RVOL"""
        tasks = [self.scan_single_stock(symbol) for symbol in self.nse_stocks]
        results = await asyncio.gather(*tasks)
        
        # Filter out errors and sort by RVOL (descending)
        valid_results = [r for r in results if 'error' not in r]
        sorted_results = sorted(valid_results, key=lambda x: x['rvol'], reverse=True)
        
        return sorted_results
    
    def get_top_gems(self, results: List[Dict], limit: int = 10) -> List[Dict]:
        """Get top gems based on RVOL criteria"""
        gems = [r for r in results if r['is_gem']]
        return gems[:limit]

# Example usage
async def main():
    scanner = RVOLScanner()
    print("Starting RVOL scan...")
    
    results = await scanner.scan_all_stocks()
    gems = scanner.get_top_gems(results)
    
    print(f"\nTop {len(gems)} Gem Candidates:")
    for i, gem in enumerate(gems, 1):
        print(f"{i}. {gem['symbol']} - RVOL: {gem['rvol']}, "
              f"Change: {gem['price_change']}%, Price: ₹{gem['current_price']}")
    
    print(f"\nTop 10 stocks by RVOL:")
    for i, result in enumerate(results[:10], 1):
        gem_indicator = "💎 GEM" if result['is_gem'] else ""
        print(f"{i}. {result['symbol']} - RVOL: {result['rvol']}, "
              f"Change: {result['price_change']}%, Price: ₹{result['current_price']} {gem_indicator}")

if __name__ == "__main__":
    asyncio.run(main())