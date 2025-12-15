import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { TrendingUp, TrendingDown, Plus, Minus, Search, Star, DollarSign, PieChart, ShoppingCart } from 'lucide-react';
import '../src/index.css';

// Mock initial portfolio data
const initialPortfolio = {
  cash: 10000000, // ₹1 crore
  invested: 0,
  totalValue: 10000000,
  pnl: 0
};

const App = () => {
  const [stocks, setStocks] = useState([]);
  const [selectedStock, setSelectedStock] = useState(null);
  const [portfolio, setPortfolio] = useState(initialPortfolio);
  const [watchlist, setWatchlist] = useState(['RELIANCE.NS', 'TCS.NS', 'HDFCBANK.NS']);
  const [searchTerm, setSearchTerm] = useState('');
  const [timeframe, setTimeframe] = useState('1D');
  const [isLoading, setIsLoading] = useState(true);

  // Fetch stocks from backend
  useEffect(() => {
    const fetchStocks = async () => {
      try {
        const response = await axios.get('http://localhost:8000/stocks');
        setStocks(response.data);
        if (response.data.length > 0) {
          setSelectedStock(response.data[0]);
        }
        setIsLoading(false);
      } catch (error) {
        console.error('Error fetching stocks:', error);
        // Fallback to mock data if API fails
        setStocks(mockStocks);
        setSelectedStock(mockStocks[0]);
        setIsLoading(false);
      }
    };

    fetchStocks();
  }, []);

  // Mock data for demonstration
  const mockStocks = [
    { 
      symbol: 'RELIANCE.NS', 
      current_price: 2543.45, 
      price_change: 2.34, 
      rvol: 2.5, 
      volume: 1250000, 
      is_gem: true,
      high: 2560.20,
      low: 2510.80,
      open: 2520.15
    },
    { 
      symbol: 'TCS.NS', 
      current_price: 3420.75, 
      price_change: -0.85, 
      rvol: 1.8, 
      volume: 890000, 
      is_gem: false,
      high: 3450.30,
      low: 3400.25,
      open: 3435.60
    },
    { 
      symbol: 'HDFCBANK.NS', 
      current_price: 1580.30, 
      price_change: 1.25, 
      rvol: 3.2, 
      volume: 2100000, 
      is_gem: true,
      high: 1590.75,
      low: 1565.40,
      open: 1575.20
    },
    { 
      symbol: 'INFY.NS', 
      current_price: 1485.60, 
      price_change: -1.50, 
      rvol: 1.2, 
      volume: 1200000, 
      is_gem: false,
      high: 1500.80,
      low: 1475.25,
      open: 1495.40
    },
    { 
      symbol: 'ICICIBANK.NS', 
      current_price: 985.45, 
      price_change: 3.20, 
      rvol: 2.8, 
      volume: 3500000, 
      is_gem: true,
      high: 995.60,
      low: 960.30,
      open: 970.25
    }
  ];

  // Filter stocks based on search term
  const filteredStocks = stocks.filter(stock => 
    stock.symbol.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Handle buying a stock
  const handleBuy = (stock) => {
    const cost = stock.current_price;
    if (portfolio.cash >= cost) {
      setPortfolio(prev => ({
        ...prev,
        cash: prev.cash - cost,
        invested: prev.invested + cost,
        totalValue: prev.totalValue
      }));
      
      if (!watchlist.includes(stock.symbol)) {
        setWatchlist(prev => [...prev, stock.symbol]);
      }
    }
  };

  // Handle selling a stock
  const handleSell = (stock) => {
    setPortfolio(prev => ({
      ...prev,
      cash: prev.cash + stock.current_price,
      invested: prev.invested - stock.current_price,
      totalValue: prev.totalValue
    }));
  };

  // Render stock item with color coding
  const renderStockItem = (stock) => {
    const isPositive = stock.price_change >= 0;
    const isSelected = selectedStock?.symbol === stock.symbol;

    return (
      <div 
        key={stock.symbol}
        className={`p-3 border-b border-gray-700 cursor-pointer hover:bg-gray-800 transition-colors ${
          isSelected ? 'bg-gray-800' : ''
        }`}
        onClick={() => setSelectedStock(stock)}
      >
        <div className="flex justify-between items-center">
          <div className="flex items-center space-x-2">
            <span className="font-medium text-white">{stock.symbol.replace('.NS', '')}</span>
            {stock.is_gem && (
              <Star className="w-4 h-4 text-yellow-400 fill-current" />
            )}
          </div>
          <span className="text-white font-mono">₹{stock.current_price.toLocaleString('en-IN')}</span>
        </div>
        <div className="flex justify-between items-center mt-1">
          <div className={`flex items-center ${isPositive ? 'text-teal-400' : 'text-red-400'}`}>
            {isPositive ? <TrendingUp className="w-4 h-4 mr-1" /> : <TrendingDown className="w-4 h-4 mr-1" />}
            <span>{isPositive ? '+' : ''}{stock.price_change}%</span>
          </div>
          <div className="text-gray-400 text-sm">
            Vol: {(stock.volume / 100000).toFixed(1)}L
          </div>
        </div>
        {stock.is_gem && (
          <div className="mt-1 text-xs bg-yellow-900/30 text-yellow-400 px-2 py-1 rounded inline-block">
            HIGH RVOL
          </div>
        )}
      </div>
    );
  };

  return (
    <div className="h-screen bg-gray-900 text-white flex flex-col">
      {/* Header */}
      <header className="bg-gray-900 border-b border-gray-700 p-3 flex justify-between items-center">
        <div className="flex items-center space-x-6">
          <h1 className="text-xl font-bold">Kite-X</h1>
          <div className="flex space-x-4">
            <button className="px-3 py-1 bg-blue-600 rounded text-sm">MARKET WATCH</button>
            <button className="px-3 py-1 text-gray-400 hover:text-white text-sm">ORDERS</button>
            <button className="px-3 py-1 text-gray-400 hover:text-white text-sm">POSITIONS</button>
            <button className="px-3 py-1 text-gray-400 hover:text-white text-sm">HOLDINGS</button>
          </div>
        </div>
        <div className="flex items-center space-x-4">
          <div className="text-right">
            <div className="text-sm text-gray-400">Account Value</div>
            <div className="text-lg font-semibold">₹{portfolio.totalValue.toLocaleString('en-IN')}</div>
          </div>
          <div className="text-right">
            <div className="text-sm text-gray-400">Cash</div>
            <div className="text-lg">₹{portfolio.cash.toLocaleString('en-IN')}</div>
          </div>
          <div className="text-right">
            <div className="text-sm text-gray-400">P&L</div>
            <div className={`text-lg ${portfolio.pnl >= 0 ? 'text-teal-400' : 'text-red-400'}`}>
              {portfolio.pnl >= 0 ? '+' : ''}{portfolio.pnl.toLocaleString('en-IN')}
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <div className="flex flex-1 overflow-hidden">
        {/* Left Panel - Market Watch */}
        <div className="w-1/4 bg-gray-800 border-r border-gray-700 flex flex-col">
          <div className="p-3 border-b border-gray-700">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-4 h-4" />
              <input
                type="text"
                placeholder="Search stocks..."
                className="w-full bg-gray-700 text-white pl-10 pr-4 py-2 rounded focus:outline-none focus:ring-1 focus:ring-blue-500"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
          </div>
          <div className="flex-1 overflow-y-auto">
            {isLoading ? (
              <div className="p-4 text-center text-gray-500">Loading stocks...</div>
            ) : (
              filteredStocks.map(renderStockItem)
            )}
          </div>
        </div>

        {/* Center Panel - Chart */}
        <div className="w-1/2 bg-gray-900 flex flex-col">
          {selectedStock ? (
            <>
              <div className="p-4 border-b border-gray-700">
                <div className="flex justify-between items-start">
                  <div>
                    <h2 className="text-2xl font-bold">{selectedStock.symbol.replace('.NS', '')}</h2>
                    <div className="flex items-center mt-1">
                      <span className="text-3xl font-mono">₹{selectedStock.current_price.toLocaleString('en-IN')}</span>
                      <span className={`ml-4 px-2 py-1 rounded text-sm ${
                        selectedStock.price_change >= 0 
                          ? 'bg-teal-900/30 text-teal-400' 
                          : 'bg-red-900/30 text-red-400'
                      }`}>
                        {selectedStock.price_change >= 0 ? '+' : ''}
                        {selectedStock.price_change}% 
                        ({(selectedStock.current_price * selectedStock.price_change / 100).toFixed(2)})
                      </span>
                    </div>
                  </div>
                  <div className="flex space-x-2">
                    <button 
                      onClick={() => handleBuy(selectedStock)}
                      className="flex items-center px-4 py-2 bg-teal-600 hover:bg-teal-700 rounded text-sm font-medium"
                    >
                      <Plus className="w-4 h-4 mr-1" /> BUY
                    </button>
                    <button 
                      onClick={() => handleSell(selectedStock)}
                      className="flex items-center px-4 py-2 bg-red-600 hover:bg-red-700 rounded text-sm font-medium"
                    >
                      <Minus className="w-4 h-4 mr-1" /> SELL
                    </button>
                  </div>
                </div>
                <div className="grid grid-cols-4 gap-4 mt-4 text-sm">
                  <div>
                    <div className="text-gray-400">Open</div>
                    <div>₹{selectedStock.open.toLocaleString('en-IN')}</div>
                  </div>
                  <div>
                    <div className="text-gray-400">High</div>
                    <div>₹{selectedStock.high.toLocaleString('en-IN')}</div>
                  </div>
                  <div>
                    <div className="text-gray-400">Low</div>
                    <div>₹{selectedStock.low.toLocaleString('en-IN')}</div>
                  </div>
                  <div>
                    <div className="text-gray-400">Volume</div>
                    <div>{(selectedStock.volume / 100000).toFixed(1)}L</div>
                  </div>
                </div>
              </div>
              <div className="flex-1 p-4">
                <div className="flex space-x-2 mb-4">
                  {['1D', '5D', '1M', '3M', '1Y', 'ALL'].map(tf => (
                    <button
                      key={tf}
                      className={`px-3 py-1 rounded text-sm ${
                        timeframe === tf 
                          ? 'bg-blue-600 text-white' 
                          : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
                      }`}
                      onClick={() => setTimeframe(tf)}
                    >
                      {tf}
                    </button>
                  ))}
                </div>
                {/* Placeholder for chart */}
                <div className="w-full h-full bg-gray-800 rounded flex items-center justify-center">
                  <div className="text-center">
                    <div className="text-gray-500 mb-2">Interactive Chart</div>
                    <div className="text-sm text-gray-600">TradingView Lightweight Charts would be integrated here</div>
                  </div>
                </div>
              </div>
            </>
          ) : (
            <div className="flex-1 flex items-center justify-center text-gray-500">
              Select a stock to view details
            </div>
          )}
        </div>

        {/* Right Panel - Order Book & Positions */}
        <div className="w-1/4 bg-gray-800 flex flex-col">
          <div className="p-3 border-b border-gray-700">
            <h3 className="font-semibold">Portfolio</h3>
          </div>
          <div className="flex-1 overflow-y-auto p-3">
            <div className="space-y-3">
              <div className="bg-gray-700/50 p-3 rounded">
                <div className="flex justify-between text-sm">
                  <span className="text-gray-400">Cash Balance</span>
                  <span>₹{portfolio.cash.toLocaleString('en-IN')}</span>
                </div>
              </div>
              <div className="bg-gray-700/50 p-3 rounded">
                <div className="flex justify-between text-sm">
                  <span className="text-gray-400">Used Margin</span>
                  <span>₹{(portfolio.invested).toLocaleString('en-IN')}</span>
                </div>
              </div>
              <div className="bg-gray-700/50 p-3 rounded">
                <div className="flex justify-between text-sm">
                  <span className="text-gray-400">Total P&L</span>
                  <span className={portfolio.pnl >= 0 ? 'text-teal-400' : 'text-red-400'}>
                    {portfolio.pnl >= 0 ? '+' : ''}{portfolio.pnl.toLocaleString('en-IN')}
                  </span>
                </div>
              </div>
            </div>

            <div className="mt-6">
              <h4 className="font-medium mb-2">Holdings</h4>
              <div className="space-y-2">
                {watchlist.slice(0, 5).map((symbol, index) => {
                  const stock = stocks.find(s => s.symbol === symbol) || mockStocks[index % mockStocks.length];
                  return (
                    <div key={index} className="bg-gray-700/30 p-2 rounded text-sm">
                      <div className="flex justify-between">
                        <span>{symbol.replace('.NS', '')}</span>
                        <span>₹{stock.current_price.toLocaleString('en-IN')}</span>
                      </div>
                      <div className={`text-xs ${stock.price_change >= 0 ? 'text-teal-400' : 'text-red-400'}`}>
                        {stock.price_change >= 0 ? '+' : ''}{stock.price_change}%
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>

            <div className="mt-6">
              <h4 className="font-medium mb-2">News Feed</h4>
              <div className="space-y-2 text-sm text-gray-300">
                <div className="p-2 bg-gray-700/30 rounded">
                  <div className="font-medium">Sensex ends higher</div>
                  <div className="text-xs text-gray-400">Index gains 0.8% on banking stocks</div>
                </div>
                <div className="p-2 bg-gray-700/30 rounded">
                  <div className="font-medium">RBI policy update</div>
                  <div className="text-xs text-gray-400">Repo rate unchanged at 6.5%</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default App;