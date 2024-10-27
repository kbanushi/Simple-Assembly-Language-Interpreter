require_relative 'command'
require_relative 'dec_instruction'
require_relative 'hlt_instruction'
require_relative 'add_instruction'
require_relative 'jmp_instruction'
require_relative 'jzs_instruction'
require_relative 'lda_instruction'
require_relative 'ldi_instruction'
require_relative 'str_instruction'
require_relative 'sub_instruction'
require_relative 'xch_instruction'

# AssemblyLanguageInterpreter class to manage and execute SAL instructions
class AssemblyLanguageInterpreter
  attr_accessor :accumulator, :memory, :program_counter, :data_register, :zero_bit, :symbol_table

  def initialize
    # Initialize CPU registers and memory
    @program_counter = 0
    @data_pointer = 128
    @memory = Array.new(256, 0) # Initialize memory (256 cells, first 128 for code, last 128 for data)
    @accumulator = 0
    @data_register = 0
    @zero_bit = false
    @symbol_table = {}
    @num_instructions = 0
    @source_instructions = []
  end

  # Main loop to load a program file and process user commands
  def run
    puts "Enter the program filename:"
    filename = gets.chomp
    load_program(filename)

    loop do
      puts "\nCommand options: s - single step, a - execute all, q - quit"
      print "> "
      command = gets.chomp.downcase

      case command
      when 's'
        execute_single_step
      when 'a'
        execute_all
      when 'q'
        puts "Exiting interpreter."
        break
      else
        puts "Invalid command. Please enter 's', 'a', or 'q'."
      end
    end
  end

  # Returns next available memory address for data
  def next_available_data_address
    idx = @data_pointer
    @data_pointer += 1
    idx
  end

  # Displays the current state of the interpreter
  def to_s
    program_memory = @memory[0..127].map.with_index { |cell, i| cell ? "#{i}: #{cell}" : nil }.compact.join(", ")
    data_memory = @memory[128..255].map.with_index(128) { |cell, i| cell ? "#{i}: #{cell}" : nil }.compact.join(", ")

    <<~STATE
      =============================
      Assembly Language Interpreter State
      -----------------------------
      Program Counter (PC): #{@program_counter}
      Data Pointer: #{@data_pointer}
      Accumulator (A): #{@accumulator}
      Data Register (B): #{@data_register}
      Zero Bit: #{@zero_bit ? 1 : 0}
      -----------------------------
      Symbol Table: #{@symbol_table}
      -----------------------------
      Program Memory (first 128 cells):
      #{program_memory.empty? ? "Empty" : program_memory}
      -----------------------------
      Data Memory (last 128 cells):
      #{data_memory.empty? ? "Empty" : data_memory}
      =============================
      Source Instructions:
      #{@source_instructions.empty? ? "Empty" : @source_instructions}
    STATE
  end

  private

  # Loads the program instructions from the file into memory
  def load_program(filename)
    if File.exist?(filename)
      File.readlines(filename).each_with_index do |line, index|
        break if index >= 128 # Program memory limit
        @source_instructions << line.strip
        @memory[index] = parse_instruction(line.strip)
      end
      puts "Program loaded successfully."
    else
      puts "File not found."
    end
  end

  # Parses each line of input to create the appropriate instruction object
  def parse_instruction(line)
    parts = line.split
    opcode, operand = parts[0], parts[1]

    case opcode
    when "DEC" then DecInstruction.new(operand)
    when "LDA" then LdaInstruction.new(operand)
    when "LDI" then LdiInstruction.new(operand)
    when "STR" then StrInstruction.new(operand)
    when "XCH" then XchInstruction.new
    when "JMP" then JmpInstruction.new(operand)
    when "JZS" then JzsInstruction.new(operand)
    when "ADD" then AddInstruction.new
    when "SUB" then SubInstruction.new
    when "HLT" then HltInstruction.new
    else
      raise "Unknown instruction: #{opcode}"
    end
  end

  # Executes a single instruction, advancing the program counter
  def execute_single_step
    instruction = @memory[@program_counter]
    @program_counter += 1
    @num_instructions += 1

    return false if instruction == 0 # Empty memory cell

    # Check for instruction limit (1000) to prevent infinite loops
    if @num_instructions == 1000
      puts "The program has executed 1000 lines of code, would you like to continue running? {y/n}"
      print "> "
      command = gets.chomp.downcase
      if command == "n"
        puts to_s
        exit 1
      end
    end

    puts "Executing #{instruction.class} at PC=#{@program_counter}..."
    instruction.execute(self)

    true
  end

  # Executes the entire program until a HALT command or out-of-bounds error
  def execute_all
    puts "Executing entire program..."

    while execute_single_step && @program_counter < 128
    end

    puts "Program halted. Check for out-of-bounds error or missing HLT command."
  end
end

# Start interpreter
asl = AssemblyLanguageInterpreter.new
asl.run
