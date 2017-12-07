require 'yaml'

class Lamp
  attr_accessor :id,:hue,:saturation,:brightness,:is_on, :transition_time, :colors

  DEFAULT_COLORS_FILE = "#{File.expand_path(File.dirname(__FILE__))}/data/default_colors.yml"
  DEFAULT_COLORS = YAML.load_file(DEFAULT_COLORS_FILE)['colors']

  def initialize(lamp_id)
    @is_on = true
    @id = lamp_id
    @hue = 0
    @saturation = 254
    @brightness = 254
    @transition_time = 0
    @colors = DEFAULT_COLORS
  end

  def color= color
    raise "unknown color of #{color}" if @colors[color].nil?

    @hue = @colors[color]['hue']
    @saturation = @colors[color]['saturation']
  end
end
