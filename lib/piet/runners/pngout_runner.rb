# Available options:
#
# strategy - strategy used by pngout (see pngout help for details)
module Piet
  class PngoutRunner < Runner

    def run_command
      vo = global_opts[:verbose] ? "-v" : "-q"
      so = tool_opts[:strategy] ? "-s#{tool_opts[:strategy]}" : ''
      `pngout #{path} -y #{vo} #{so}`
    end

    def cmd_name
      'pngout'
    end
  end
end