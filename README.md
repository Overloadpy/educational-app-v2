# Project Kite-X - Zerodha Kite Clone

A pixel-perfect clone of the Zerodha Kite trading platform with advanced algorithmic scanning capabilities for the Indian stock market.

## Features
- Real-time Indian stock market data (NSE/BSE)
- Custom "Gem Finder" algorithm using Relative Volume (RVOL)
- Paper trading with ₹10,000,000 starting balance
- Interactive charts with TradingView integration
- Three-column density layout (Market Watchlist, Charting Canvas, Portfolio)

## Tech Stack
- Frontend: React.js (Vite) with Tailwind CSS
- Backend: Python FastAPI
- Data: yfinance for Indian market data
- Charts: TradingView Lightweight Charts

## Folder Structure
```
project-kite-x/
├── backend/
│   ├── scanner/
│   │   └── rvol_scanner.py
│   ├── data/
│   │   └── nse_stocks.py
│   └── main.py
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   ├── styles/
│   │   └── App.jsx
│   ├── public/
│   └── package.json
└── docs/
```