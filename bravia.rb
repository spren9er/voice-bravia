# frozen_string_literal: true

Dir[File.expand_path 'bravia/**/*.rb'].each { |f| require_relative(f) }

module Bravia; end
