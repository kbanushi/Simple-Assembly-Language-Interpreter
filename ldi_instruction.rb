require_relative 'command'

# Implementation of Command class to load integer value into accumulator register
class LdiInstruction < Command
  # Initialize with integer value
  def initialize(value)
    super("LDI")
    @value = value.to_i
  end

  # Set accumulator register
  def execute(context)
    context.accumulator = @value
  end
end
