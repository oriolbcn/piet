module Piet
  class JpegrescanRunner < Runner

    def run_command
      vo = global_opts[:verbose] ? "-v" : "-q"
      `#{File.dirname(__FILE__)}/../../../bin/jpegrescan -s #{vo} #{path} #{path}`

    end

    def cmd_name
      'jpegrescan'
    end
  end
end