module Piet
  class OptipngRunner < Runner

    def run_command
      vo = global_opts[:verbose] ? "-v" : "-quiet"
      `optipng -o7 #{vo} #{path}`
    end

    def cmd_name
      'optipng'
    end
  end
end