module Luxafor
  module Toggl
    class State
      DEFAULT_TIME = DateTime.parse('2000-01-01 00:00:00')

      include ValueSemantics.for_attributes {
        state    Symbol,   default: :idle,        coerce: true
        as_of    DateTime, default: DEFAULT_TIME, coerce: true
      }

      def self.coerce_state(value)
        value.to_sym
      end

      def self.coerce_as_of(value)
        DateTime.parse(value)
      end

      def self.new_from_task(task)
        instance = allocate

        instance.initialize_from_task(task)
        instance
      end

      def initialize_from_task(task)
        @state = determine_state_from_task(task)
        @as_of = determine_as_of_from_task(task)
      end

      def sufficiently_different_from?(other_state)
        return true if @state != other_state.state

        false
      end

      def colour
        case state
        when :idle
          '000000'
        when :busy
          'FF0000'
        when :available
          '00FF00'
        end
      end

      def store!(destination)
        data = {
          'state' => state,
          'as_of' => as_of.to_s,
        }

        File.unlink(destination) if File.exist?(destination)

        File.open(destination, 'w') do |f|
          f.write(Oj.dump(data))
        end
      end

      private

      def determine_state_from_task(task)
        return :idle if     task.nil?        # There is no latest task at all...
        return :busy unless task.key? 'stop' # There's a task with no stop time, still in progress.

        now        = DateTime.now.to_time.to_i
        stopped_at = DateTime.parse(task['stop']).to_time.to_i

        (now - stopped_at) >= Luxafor::Toggl.idle_time ? :idle : :available
      end

      def determine_as_of_from_task(task)
        state = determine_state_from_task(task)

        if state == :busy
          DateTime.parse(task['start'])
        elsif state == :available
          DateTime.parse(task['stop'])
        elsif state == :idle
          return DEFAULT_TIME if task.nil?

          DateTime.parse(task['stop'])
        else
          raise "Cannot determine as_of from task in state #{state}: #{task}"
        end
      end
    end
  end
end
