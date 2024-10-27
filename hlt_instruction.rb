require_relative 'command'

# Implementation of Command class to exit program on HLT command
class HltInstruction < Command
  def initialize
    super("HLT")
  end

  # Print state of interpreter before exiting
  def execute(context)
    puts context
    exit 0
  end
end