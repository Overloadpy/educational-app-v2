/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'primary-dark': '#191919',
        'panel-dark': '#1e222d',
        'border-dark': '#2a2a2a',
        'accent-dark': '#383838',
        'bullish': '#00d4aa',  // Teal green
        'bearish': '#ff5252',  // Coral red
      }
    },
  },
  plugins: [],
}