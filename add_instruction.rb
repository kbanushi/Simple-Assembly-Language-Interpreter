require_relative 'command'

# Implementation of Command class to support adding values
class AddInstruction < Command
  def initialize
    super("ADD")
  end

  # Add contents of the accumulator and data register, store the result in accumulator
  def execute(context)
    sum = context.accumulator + context.data_register
    if sum > 32767 || sum < -32768 # Handle overflow: if sum is out of range, don't update accumulator
      return
    end

    context.accumulator = sum
    context.zero_bit = (context.accumulator == 0) # Set zero bit
  end
end