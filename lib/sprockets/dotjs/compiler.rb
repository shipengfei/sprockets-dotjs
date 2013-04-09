require 'sprockets'
require 'tilt/template'
require 'v8'
require 'digest/md5'

module Sprockets
  module DotJS
    class Compiler < Tilt::Template
      def self.default_mime_type
        'application/javascript'
      end

      def prepare
      end


      def initialize_engine
        dotjs_lib = open(::File.join(::File.dirname(__FILE__), '..', '..', 'support', 'doT.js')).read
        @@context = ::V8::Context.new
        @@context.eval(dotjs_lib)
      end

      def build_dependencies(set = [],environment,path)
        processed_asset = environment.find_asset(path, :bundle => false)
        dependency_paths = processed_asset.send(:dependency_paths).each do |dependency_file|
          if !set.include? dependency_file.pathname
            set << dependency_file.pathname
            build_dependencies(set,environment,dependency_file.pathname)
          end
        end
        set
      end

      def render(scope=Object.new, locals={}, &block)
        @@context['def'] = {}
        dep = []
        scope._dependency_assets.each {|pathname|
          if scope.pathname.to_s != pathname
            dep << pathname
            build_dependencies(dep,scope.environment,pathname)
          end
        }
        dep.reverse_each do |pathname|
          @@context['doT']['compile'].call(open(pathname).read,@@context['def'])
        end
        @@context['doT']['compile'].call(data,@@context['def']).to_s
      end
    end
  end
end
