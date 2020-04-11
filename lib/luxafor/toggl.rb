require "awesome_print"
require "date"
require "value_semantics"

require 'luxafor'
require 'togglv8'

require "luxafor/toggl/version"
require "luxafor/toggl/client"
require "luxafor/toggl/state"

module Luxafor
  module Toggl
    class Error < StandardError; end

    extend self

    EXPECTED_ERRORS = [
      # Filelock::ExecTimeout,
      # Filelock::WaitTimeout,
      # KeyError,
      # Oj::Error,
      # Oj::ParseError,
      # Oj::DepthError,
      # Oj::LoadError,
      # ValueSemantics::MissingAttributes,
    ].freeze

    attr_writer :toggl_key, :luxafor_key, :state_file

    def toggl_key
      @toggl_key || ENV.fetch('TOGGL_KEY')
    end

    def luxafor_key
      @luxafor_key || ENV.fetch('LUXAFOR_KEY')
    end

    def state_file
      @state ||= ENV.fetch("LUXAFOR_TOGGL_STATE_FILE", "/tmp/#{Etc.getpwuid(Process.euid).name}-luxafor-toggle-state.json")
    end

    def toggl_client
      @toggl_client ||= TogglV8::API.new(toggle_key)
    end

    def luxafor_client
      @luxafor_client ||= Luxafor::Client.new(luxafor_key)
    end
  end
end
