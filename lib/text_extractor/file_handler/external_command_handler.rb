# frozen_string_literal: true

require 'pathname'

module TextExtractor
  class ExternalCommandHandler < FileHandler
    # TODO: Extract this to a proper module
    # Executes the given command through IO.popen and yields an IO object
    # representing STDIN / STDOUT
    #
    # Due to how popen works the command will be executed directly without
    # involving the shell if cmd is an array.
    require 'fileutils'
    def shellout(cmd, options = {}, &block)
      mode = "r+"
      IO.popen(cmd, mode) do |io|
        io.set_encoding("ASCII-8BIT") if io.respond_to?(:set_encoding)
        io.close_write unless options[:write_stdin]
        block.call(io) if block_given?
      end
    end

    FILE_PLACEHOLDER = '__FILE__'.freeze

    def create_tempfile!(file)
      return unless file.is_a? StringIO
      
      tempfile = Tempfile.new
      tempfile.write(file.read)
      tempfile.flush
    end

    def text(file)
      tempfile = create_tempfile! file
      file = tempfile if tempfile.present?
      cmd = @command.dup
      cmd[cmd.index(FILE_PLACEHOLDER)] = Pathname(file).to_s
      result = shellout(cmd){ |io| io.read }.to_s
      tempfile&.close
      tempfile&.unlink if tempfile.respond_to? :unlink
      result
    end

    def accept?(content_type)
      super and available?
    end

    def available?
      @command.present? and File.executable?(@command[0])
    end

    def self.available?
      new.available?
    end
  end
end
