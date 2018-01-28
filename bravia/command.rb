# frozen_string_literal: true

require_relative 'command/builder'

module Bravia
  class Command
    include Builder

    class << self
      extend Forwardable

      def_delegators Repository, :[], :all
    end

    attr_reader :key

    def initialize(key, ircc_keys)
      @key       = key.to_s
      @ircc_keys = ircc_keys
    end

    def call
      @ircc_keys.each do |key|
        IRCCCommand[key].perform
        sleep 0.7
      end
    end
  end
end
