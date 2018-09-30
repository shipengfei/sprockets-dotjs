require 'sprockets'
require 'tilt/template'
require 'digest/md5'
require 'execjs'

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
        @@context = ExecJS.compile(dotjs_lib)
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
        @@context ||= initialize_engine
        @@context.exec("def = {}")
        dep = []
        scope._dependency_assets.each {|pathname|
          if scope.pathname.to_s != pathname
            dep << pathname
            build_dependencies(dep,scope.environment,pathname)
          end
        }
        dep.reverse_each do |pathname|
          @@context.exec("doT.compile(#{MultiJson.encode(open(pathname).read)},def).toString()")
        end
        @@context.exec("return doT.compile(#{MultiJson.encode(data)},def).toString()")
      end
    end
  end
end
