# frozen_string_literal: true

require_relative '../configuration'

module Bravia
  class Command
    IRCC_CODES = {
      'off'          => 'AAAAAQAAAAEAAAAvAw==',
      'input'        => 'AAAAAQAAAAEAAAAlAw==',
      'mute'         => 'AAAAAQAAAAEAAAAUAw==',
      'volume_up'    => 'AAAAAQAAAAEAAAASAw==',
      'volume_down'  => 'AAAAAQAAAAEAAAATAw==',
      'channel_up'   => 'AAAAAQAAAAEAAAAQAw==',
      'channel_down' => 'AAAAAQAAAAEAAAARAw==',
      'num0'         => 'AAAAAQAAAAEAAAAJAw==',
      'num1'         => 'AAAAAQAAAAEAAAAAAw==',
      'num2'         => 'AAAAAQAAAAEAAAABAw==',
      'num3'         => 'AAAAAQAAAAEAAAACAw==',
      'num4'         => 'AAAAAQAAAAEAAAADAw==',
      'num5'         => 'AAAAAQAAAAEAAAAEAw==',
      'num6'         => 'AAAAAQAAAAEAAAAFAw==',
      'num7'         => 'AAAAAQAAAAEAAAAGAw==',
      'num8'         => 'AAAAAQAAAAEAAAAHAw==',
      'num9'         => 'AAAAAQAAAAEAAAAIAw==',
      'enter'        => 'AAAAAQAAAAEAAAALAw=='
    }.freeze

    class IRCCCommand
      def self.[](key)
        new(key)
      end

      def initialize(key)
        @key = key.to_s
      end

      def perform
        system(request)
      end

      private

      def request
        %(
          curl \
            -w "%{http_code}" --silent -XPOST "http://#{ip_address}/sony/IRCC" \
            -d "#{ircc_xml}" -H "Content-Type: text/xml; charset=UTF-8" \
            -H 'SOAPACTION: "urn:schemas-sony-com:service:IRCC:1#X_SendIRCC"' \
            -H "X-Auth-PSK: 0000"
        )
      end

      def ircc_xml
        xml =
          <<~XML
            <?xml version="1.0" encoding="utf-8"?>
              <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                 <s:Body>
                   <u:X_SendIRCC xmlns:u="urn:schemas-sony-com:service:IRCC:1">
                     <IRCCCode>#{ircc_code}</IRCCCode>
                   </u:X_SendIRCC>
                 </s:Body>
              </s:Envelope>
          XML
        xml.gsub('"', '\"')
      end

      def ircc_code
        IRCC_CODES[@key]
      end

      def ip_address
        Bravia.configuration.ip_address
      end
    end
  end
end
