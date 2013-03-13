# Sprockets::Dotjs

Compile doT.JS templates (`jst.djs` extension) into rails `JST` env variable

Supports doT.JS partial feature by using Sprocket's `depend_on` directive

## Installation

Add this line to your application's Gemfile:

    gem 'sprockets-dotjs'

And then execute:

    $ bundle

## Usage

Put doT.js template files inside the `assets/javascript` directory and generate them by calling `JST["#{file_path}"]()`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
