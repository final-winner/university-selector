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
        border: {
          DEFAULT: '#E2E8F0',
          color: '#E2E8F0',
        },
        text: {
          primary: '#1A202C',
          secondary: '#4A5568',
        },
        light: '#F8FAFC',
      },
      fontFamily: {
        sans: ['Microsoft YaHei', 'Arial', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
