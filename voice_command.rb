# frozen_string_literal: true

module VoiceCommand
  module_function

  def build(&block)
    @voice_commands = {}
    class_eval(&block)
  end

  def [](param)
    @voice_commands[normalize(param)]
  end

  def register(voices, command)
    [*voices].each do |v|
      @voice_commands[v.to_s] = command
    end
  end

  def normalize(param)
    param.to_s.delete('').downcase
  end
end
