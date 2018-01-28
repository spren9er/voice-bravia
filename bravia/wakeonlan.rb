# frozen_string_literal: true

require_relative 'configuration'

module Bravia
  module Wakeonlan
    module_function

    def perform
      system(wakeonlan)
    end

    private

    def wakeonlan
      wakeonlan = File.join(path, 'wakeonlan')
      "#{wakeonlan} #{mac_address}"
    end

    def path
      Bravia.configuration.wakeonlan_path
    end

    def mac_address
      Bravia.configuration.mac_address
    end
  end
end
