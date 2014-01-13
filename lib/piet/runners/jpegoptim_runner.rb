# Available options:
#
# quality - quality used by jpegoptim
module Piet
  class JpegoptimRunner < Runner

    def run_command
      quality = (0..100).include?(tool_opts[:quality]) ? tool_opts[:quality] : 100
      vo = global_opts[:verbose] ? "-v" : "-q"
      `jpegoptim -f -m#{quality} --strip-all #{vo} #{path}`
    end

    def cmd_name
      'jpegoptim'
    end
  end
end