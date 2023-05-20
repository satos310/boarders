const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    jquery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)

// raty.jsを使用できるように設定
// environment.plugins.prepend('Provide',
//   new webpack.ProvidePlugin({
//     $: 'jquery/src/jquery',
//     jQuery: 'jquery/src/jquery',

//   })
// )

module.exports = environment
