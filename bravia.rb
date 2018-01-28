# frozen_string_literal: true

bravia_path = File.expand_path('bravia/**/*.rb', File.dirname(__FILE__))
Dir[bravia_path].each { |f| require_relative(f) }

module Bravia; end
