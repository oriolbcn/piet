# Abstract runner to encapsulate common functionality
# To implement a new runner, just create a subclass and implement the methods run and cmd_name
module Piet
  class Runner

    attr_accessor :path, :global_opts, :tool_opts

    def initialize(path, global_opts, tool_opts)
      @path = path
      @global_opts = global_opts
      @tool_opts = tool_opts || {}
    end

    def run
      begin
        output = run_command
        puts output if global_opts[:verbose]
      rescue Exception => e
        Piet.logger.warn "error while executing #{cmd_name} command: #{e}"
      end
    end

    def cmd_name
      ''
    end
  end
end