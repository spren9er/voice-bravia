# frozen_string_literal: true

require_relative 'configuration'

module Bravia
  class Wakeonlan
    def call
      system(wakeonlan)
    end

    private

    def wakeonlan
      script = File.join(path, 'wakeonlan')
      "#{script} #{mac_address}"
    end

    def path
      Bravia.configuration.wakeonlan_path
    end

    def mac_address
      Bravia.configuration.mac_address
    end
  end
end
