# Abstract class to provide abstract definition of execute command
class Command
  attr_reader :opcode

  # Initialize with opcode
  def initialize(opcode)
    @opcode = opcode
  end

  def execute(context)
  end
end