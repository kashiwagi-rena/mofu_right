/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require("daisyui"),
    require('@tailwindcss/forms'),
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ],
  daisyui: {
    themes: ["pastel"],
  },
  theme: {
    extend: {
      fontFamily: {
        yomogi: ['Yomogi', 'cursive'],
      },
    },
  },
}
