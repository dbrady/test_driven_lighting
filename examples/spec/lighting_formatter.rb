require 'rspec'
require 'yaml'
require_relative '../../lib/test_driven_lighting'

class LightingFormatter
  RSpec::Core::Formatters.register self,
                                   :example_passed,
                                   :example_failed,
                                   :example_pending,
                                   :dump_summary,
                                   :close

  def initialize data
    config = YAML::load_file(File.expand_path('~/.test_driven_lighting.conf'))
    @sender = Sender.new config[:bunny]
  end

  def example_passed test_data
    @sender.message_send 'pass','test'
  end

  def example_failed test_data
    @sender.message_send 'fail','test'
  end

  def example_pending test_data
    @sender.message_send 'pending', 'test'
  end

  def dump_summary summary
    if summary.failed_examples.any?
      @sender.message_send 'fail','suite'
    elsif summary.pending_examples.any?
      @sender.message_send 'pending', 'suite'
    else
      @sender.message_send 'pass','suite'
    end
  end

  def close param
    @sender.close_connection
  end

end
