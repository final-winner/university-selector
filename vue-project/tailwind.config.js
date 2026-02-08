/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#1E3A8A',
          light: '#3B82F6',
          dark: '#1E40AF',
        },
        secondary: {
          DEFAULT: '#FF6B35',
          light: '#FF8A3C',
          dark: '#E86208',
        },
        tertiary: '#EC4899',
        accent: '#7B61FF',
        search: '#FF6B35',
        data: '#10b981',
      },
      fontFamily: {
        sans: ['Microsoft YaHei', 'Arial', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
