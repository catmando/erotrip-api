module.exports = {
  test: /\.(js|jsx)?(\.erb)?$/,
  exclude: /node_modules/,
  loader: 'babel-loader'
  // ,
  // query: {
  //   presets: ['react', 'es2015', 'stage-2']
  // }
}
