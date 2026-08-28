/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./app/**/*.{js,jsx,ts,tsx}", "./components/**/*.{js,jsx,ts,tsx}"],
  presets: [require("nativewind/preset")],
  theme: {
    extend: {
      colors: {
        brand:      "#5b4fcf",
        brandDark:  "#7c3aed",
        brandLight: "#ede9fe",
        accent:     "#f59e0b",
        chinese:    "#fff3e0",
        indian:     "#fce4ec",
        hispanic:   "#e8f5e9",
        surface:    "#ffffff",
        surfaceAlt: "#fffbf0",
        textPrimary:"#1a1a2e",
        textMuted:  "#6b7280",
      },
      fontFamily: {
        sans:      ["Nunito_400Regular"],
        semibold:  ["Nunito_600SemiBold"],
        bold:      ["Nunito_700Bold"],
        extrabold: ["Nunito_800ExtraBold"],
        black:     ["Nunito_900Black"],
      },
    },
  },
  plugins: [],
};
