require_relative 'command'

# Implementation of Command class to jump to address if zero bit is true
class JzsInstruction < Command
  # Initialize with address to jump to
  def initialize(address)
    super("JZS")
    @address = address.to_i
  end

  # Set program counter to address if zero bit is true
  def execute(context)
    context.program_counter = @address if context.zero_bit
  end
end