const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        mediumgray: "#84848C",
        stronggray: "#6A6D69", /*text*/
        mediumgreen: '#48683eb9', /*hover*/
        stronggreen: "#22331D", /*sidebar*/
        lightorange: "#ffd7b5",
        mediumorange: "#F7A465",
        darkorange: "#F65A11", /*buttons & active*/
        linen: "#EFEDE7", /*background*/
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
  variants: {
    extend: {
      borderWidth: ['hover', 'focus'],
    },
  },
}
