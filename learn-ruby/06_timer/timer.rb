class Timer
  attr_accessor :hours, :minutes, :seconds

  def initialize
    @hours = 0
    @minutes = 0
    @seconds = 0
  end

  def seconds=(time_in_seconds)
    @hours = time_in_seconds / 3600
    remaining_seconds = time_in_seconds % 3600
    @minutes = remaining_seconds / 60
    @seconds = remaining_seconds % 60
  end

  def time_string
    hour_string = padded(@hours)
    minute_string = padded(@minutes)
    second_string = padded(@seconds)

    return "#{hour_string}:#{minute_string}:#{second_string}"
  end

  private

  def padded(number)
    if number < 10
      result = "0#{number}"
    else
      result = "#{number}"
    end
    return result
  end

end
