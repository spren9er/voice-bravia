# frozen_string_literal: true

module Bravia
  class Command
    class Repository
      class << self
        def [](key)
          commands.detect { |command| command.key == key.to_s }
        end

        def all
          commands
        end

        def <<(command)
          commands << command
        end

        def commands
          @commands ||= []
        end
      end
    end
  end
end
