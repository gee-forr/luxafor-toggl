module Luxafor
  module Toggl
    class State
      include ValueSemantics.for_attributes {
        state    Symbol,   default: :idle
        as_of    DateTime, default: DateTime.parse('2000-01-01 00:00:00')
      }
    end
  end
end
