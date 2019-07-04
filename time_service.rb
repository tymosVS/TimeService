# frozen_string_literal: true

# simple module for work with time
module TimeService
  class TimeRecord
    attr_accessor :hours, :minutes, :meridiem
    def time(time_string)
      tmp = /(\d{1,2}):(\d{2}) (AM|PM)/.match(time_string)
      @hours = tmp[1].to_i
      @minutes = tmp[2].to_i
      @meridiem = tmp[3]
    end

    def to_s
      @hours.to_s + ':' + @minutes.to_s + ' ' + @meridiem
    end
  end

  class TimeSystem < TimeRecord
    def initialize(str = '00:00 AM')
      time(str)
    end

    def add_minutes(str, minutes)
      time(str)
      @minutes += minutes
      if @minutes > 60
        @hours += @minutes/60
        @minutes = @minutes%60
      end
      if @hours > 12
        @hours = @hours % 12
        if @meridiem == "AM"
          @meridiem = "PM"
        else
          @meridiem == "AM"
        end
      end
      to_s
    end
  end
end

my_time = TimeService::TimeSystem.new.add_minutes('9:24 PM', 10)

puts my_time.to_s