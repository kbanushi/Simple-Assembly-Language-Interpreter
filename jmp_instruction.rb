require_relative 'command'

# Implementation of Command class to jump to address in program memory
class JmpInstruction < Command
  # Initialize with address to jump to
  def initialize(address)
    super("JMP")
    @address = address.to_i
  end

  # Jump to address by setting program_counter
  def execute(context)
    context.program_counter = @address
  end
end