

class Lamp
  attr_accessor :id,:hue,:saturation,:brightness,:is_on, :transition_time

  def initialize(lamp_id)
    @is_on = true
    @id = lamp_id
    @hue = 0
    @saturation = 254
    @brightness = 10
    @transition_time = 0
  end

  def color= color
    @hue = case color
      when 'green' then 25000
      when 'red'   then 0
      else raise "unknown color #{color}"
    end
  end
end
