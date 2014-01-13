# Available options:
#
# compression - compression ratio used by advpng (0..4)
# iterations - number of iterations
module Piet
  class AdvpngRunner < Runner

    def run_command
      vo = global_opts[:verbose] ? "" : "-q"
      co = tool_opts[:compression] ? "-#{tool_opts[:compression]}" : ''
      io = tool_opts[:iterations] ? "-i #{tool_opts[:iterations]}" : ''
      `advpng -z #{vo} #{co} #{io} #{path}`
    end

    def cmd_name
      'advpng'
    end
  end
end