var webpack = require('webpack');

module.exports = {
  entry: {
    app: __dirname + '/src/index.js',
  },
  output: {
    path: __dirname + '/build/',
    filename: '[name].js',
  },
  plugins: [
    new webpack.ProvidePlugin({
      riot: 'riot',
    }),
    new webpack.optimize.UglifyJsPlugin({ 
      minimize: true, 
      mangle: true,
      output: { 
        comments: false, 
        ascii_only: true,
      },
    }),
  ],

  module: {

    preLoaders: [{ 
      test: /\.tag$/, 
      exclude: /node_modules/, 
      loader: 'riotjs-loader', 
      query: { type: 'es6' } 
    }],

    loaders: [{ 
      test: /\.jsx?|\.tag$/, 
      exclude: [/bower_components/, /node_modules/],
      include: /src/, 
      loader: 'babel-loader', 
      query: { modules: 'common', stage: 0 } 
    }, { 
      test: /\.less$/, 
      loader: 'style!css!less!autoprefixer' 
    }, { 
      test: /\.css$/, 
      loader: 'style!css!autoprefixer' 
    }, {
      test: /\.(png|jpg)$/, 
      loader: 'url-loader?limit=1'
    }, {
      test: /\.scss$/,
      loader: 'style!css!sass!autoprefixer'
    }]
  },

  
  devServer: {
    contentBase: './build/',
    host: '0.0.0.0',
    port: 1337,
    hot: true,
    inline: true
  }
};