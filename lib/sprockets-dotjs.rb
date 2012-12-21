require "sprockets-dotjs/version"
require 'sprockets/dotjs/compiler'

Sprockets.register_engine '.djs', ::Sprockets::DotJS::Compiler
module Sprockets
  module DotJS
    class Engine < ::Rails::Engine

    end
  end
end