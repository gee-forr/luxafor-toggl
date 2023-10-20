module Luxafor
  module Toggl
    class Client
      def initialize(toggl: Luxafor::Toggl.toggl_client, luxafor: Luxafor::Toggl.luxafor_client, state: Luxafor::Toggl::state_file)
        @toggl      = toggl
        @luxafor    = luxafor
        @state_file = state
      end

      def execute!
        return false unless current_state.sufficiently_different_from?(stored_state)

        luxafor.on(current_state.colour)

        current_state.store!(state_file)

        true
      end

      private

      attr_reader :toggl, :luxafor, :state_file

      def latest_task
        start         = DateTime.now - 1
        @_latest_task = toggl.get_time_entries(start_date: start).max_by { |task| Time.parse(task["stop"]) }
      end

      def current_state
        @_current_state ||= State.new_from_task(latest_task)
      end

      def stored_state
        return State.new unless File.exist?(state_file)

        file_contents = File.new(state_file).read.to_s
        state_json    = Oj.load(file_contents)

        State.new(state: state_json['state'], as_of: state_json['as_of'])
      end
    end
  end
end
