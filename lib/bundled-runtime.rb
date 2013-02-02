require "java"
require "bundled-runtime/version"

module Bundled
  module Runtime
    class Container
      attr_accessor :container

      import org.jruby.embed.ScriptingContainer
      import org.jruby.embed.LocalContextScope
      import org.jruby.embed.LocalVariableBehavior

      def initialize
        self.container = ScriptingContainer.new(LocalContextScope::SINGLETHREAD, LocalVariableBehavior::TRANSIENT)
      end

      def load_bundler!
        self.container.run_scriptlet <<-SCRIPT
          require 'bundler'
          Bundler.require
SCRIPT
      end

      def terminate
        self.container.terminate
      end
    end
  end
end
