# Project Kite-X Folder Structure

## Overview
Project Kite-X is organized into three main directories: backend, frontend, and docs. The backend handles data processing and RVOL scanning, while the frontend provides the trading dashboard UI.

## Directory Structure
```
project-kite-x/
├── backend/
│   ├── scanner/
│   │   └── rvol_scanner.py          # Core RVOL algorithm implementation
│   ├── data/
│   ├── utils/
│   ├── main.py                      # FastAPI backend server
│   └── requirements.txt             # Python dependencies
├── frontend/
│   ├── src/
│   │   ├── components/              # React components
│   │   ├── styles/                  # CSS/styling files
│   │   ├── App.jsx                  # Main dashboard component
│   │   └── main.jsx                 # Entry point
│   ├── public/
│   ├── assets/
│   ├── package.json                 # Node.js dependencies
│   ├── index.html                   # Main HTML file
│   ├── tailwind.config.js           # Tailwind CSS configuration
│   ├── postcss.config.js            # PostCSS configuration
│   └── vite.config.js               # Vite configuration
└── docs/
    └── folder_structure.md          # This document
```

## Key Files

### Backend
- `backend/scanner/rvol_scanner.py`: Implements the RVOL algorithm with the formula:
  - RVOL = (Average Volume of Last 10 Days) / (Average Volume of Last 91 Days)
  - Identifies "Gem Candidates" with RVOL > 2.0 and price change between -1% and +2%
- `backend/main.py`: FastAPI server with endpoints for stocks, gems, and scanning
- `backend/requirements.txt`: Lists dependencies including yfinance, pandas, and FastAPI

### Frontend
- `frontend/src/App.jsx`: Main React component implementing the three-column layout:
  - Left Panel (25%): Market Watchlist
  - Center Panel (50%): Interactive Charting Canvas
  - Right Panel (25%): Portfolio/Orders/News Feed
- `frontend/src/index.css`: Implements Zerodha Kite's dark theme color palette
- `frontend/package.json`: Lists React, TradingView charts, and UI dependencies

## Color Scheme (Zerodha Kite Identity)
- Background Dark: `#191919` (Main Canvas)
- Panels: `#1e222d`
- Text Primary: `#e0e0e0`
- Text Secondary: `#9b9b9b`
- Bullish (Up/Buy): `#00d4aa` (Teal Green)
- Bearish (Down/Sell): `#ff5252` (Coral Red)
- Borders: `#2a2a2a`
- Accent: `#383838`

## Features Implemented
1. **RVOL Scanner**: Identifies high-volume stocks using the relative volume formula
2. **Paper Trading**: ₹10,000,000 starting balance with buy/sell functionality
3. **Three-Column Layout**: Following Zerodha Kite's design pattern
4. **Real-time Data**: Fetches Indian stock market data via yfinance
5. **Gem Indicators**: Highlights stocks meeting RVOL criteria