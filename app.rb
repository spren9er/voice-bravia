#!/usr/bin/env ruby
# frozen_string_literal: true

require 'sinatra'
require_relative 'bravia'
require_relative 'voice_command'

set :bind, '0.0.0.0'

Bravia.config do |config|
  config.wakeonlan_path = File.join(File.dirname(__FILE__), 'vendor')
  config.ip_address     = '192.168.178.26'
  config.mac_address    = '34:68:95:17:85:15'
end

Bravia::Command.build do
  register :on,           :on
  register :off,          :off
  register :mute,         :mute
  register :channel_up,   :channel_up
  register :channel_down, :channel_down
  register :volume_up,    %i[volume_up volume_up]
  register :volume_down,  %i[volume_down volume_down]
  register :source_ap,    %i[input input]
  register :source_tv,    %i[input input input]
  register :ard,          '001'
  register :zdf,          '002'
  register :rtl,          '303'
  register :sat1,         '304'
  register :pro7,         '305'
  register :vox,          '306'
  register :kabel1,       '307'
  register :rtl2,         '308'
  register :'3sat',       '309'
  register :arte,         '310'
  register :servustv,     '311'
  register :sport1,       '540'
end

VoiceCommand.build do
  register %i[an ein],                  Bravia::Wakeonlan.new
  register :aus,                        Bravia::Command[:off]
  register %i[laut lauter],             Bravia::Command[:volume_up]
  register %i[leise leiser],            Bravia::Command[:volume_down]
  register %i[still stumm],             Bravia::Command[:mute]
  register :appletv,                    Bravia::Command[:source_ap]
  register :tv,                         Bravia::Command[:source_tv]
  register :hoch,                       Bravia::Command[:channel_up]
  register :runter,                     Bravia::Command[:channel_down]
  register :ard,                        Bravia::Command[:ard]
  register :zdf,                        Bravia::Command[:zdf]
  register :rtl,                        Bravia::Command[:rtl]
  register %i[sat1 sateins],            Bravia::Command[:sat1]
  register %i[pro7 prosieben],          Bravia::Command[:pro7]
  register :vox,                        Bravia::Command[:vox]
  register %i[kabel1 kabeleins],        Bravia::Command[:kabel1]
  register %i[rtl2 rtlzwei],            Bravia::Command[:rtl2]
  register %i[3sat dreisat],            Bravia::Command[:'3sat']
  register :arte,                       Bravia::Command[:arte]
  register :servustv,                   Bravia::Command[:servustv]
  register %i[sport1 sporteins],        Bravia::Command[:sport1]
end

get '/tv/:command' do |command|
  VoiceCommand[command]&.call
  puts "command: #{command}"
end
