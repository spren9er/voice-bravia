# frozen_string_literal: true

module Bravia
  def self.config
    @config ||= Configuration.new
    yield @config
  end

  def self.configuration
    @config
  end

  Configuration = Struct.new(:wakeonlan_path, :ip_address, :mac_address)
end
