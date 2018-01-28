# frozen_string_literal: true

require_relative 'repository'

module Bravia
  class Command
    module Builder
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def build(&block)
          @builder ||= BuilderObject.new
          @builder.instance_eval(&block)
        end
      end

      class BuilderObject
        attr_reader :repo

        def initialize
          @repo = Repository
        end

        def register(key, irrc_arg)
          ircc_keys = to_ircc_keys(irrc_arg)
          @repo << Command.new(key, ircc_keys)
        end

        private

        def to_ircc_keys(irrc_arg)
          case irrc_arg
          when /\d{3}/
            irrc_arg.chars.map { |char| "num#{char}" }
          else
            [*irrc_arg]
          end
        end
      end
    end
  end
end
