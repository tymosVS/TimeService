# frozen_string_literal: true

# simple module for work with time
module TimeService
  # decimal time view
  class TimeRecord
    attr_accessor :hours, :minutes, :meridiem
    def time(time_string)
      tmp = /(\d{1,2}):(\d{2}) (AM|PM)/.match(time_string)
      @hours = tmp[1].to_i
      @minutes = tmp[2].to_i
      @meridiem = tmp[3]
    end

    def switching_meridiem
      @meridiem = @meridiem == 'PM' ? 'AM' : 'PM'
    end

    def to_s
      @hours.to_s + ':' + @minutes.to_s.rjust(2, '0') + ' ' + @meridiem
    end
  end
  # sub class for calculate change time
  class TimeSystem < TimeRecord
    def initialize(str = '00:00 AM')
      time(str)
    end

    def shift_hours(hours)
      @hours += hours
      if @hours > 12
        switching_meridiem if ((@hours / 12) % 2).odd?
        @hours = @hours % 12
      end
      to_s
    end

    def shift_minutes(minutes)
      @minutes += minutes
      if @minutes > 60
        shift_hours(@minutes / 60)
        @minutes = @minutes % 60
      end
      to_s
    end

    def add_minutes(str, minutes)
      time(str)
      shift_minutes(minutes)
    end

    def add_hours(str, hours)
      time(str)
      shift_hours(hours)
    end
  end
end

my_time = TimeService::TimeSystem.new('12:00 AM')

# puts my_time.add_minutes('9:25 AM', 25)
puts my_time.shift_hours(88)
puts my_time.shift_minutes(25)
