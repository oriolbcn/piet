require 'logger'
require_relative 'piet/railtie' if defined?(Rails)
require_relative 'piet/carrierwave_extension'
require_relative 'piet/runners/runner'
require_relative 'piet/runners/optipng_runner'
require_relative 'piet/runners/pngout_runner'
require_relative 'piet/runners/advpng_runner'
require_relative 'piet/runners/jpegoptim_runner'
require_relative 'piet/runners/jpegrescan_runner'

module Piet
  class << self
    VALID_EXTS = %w{ png gif jpg jpeg }
    JPEG_TOOLS = [:jpegoptim, :jpegrescan]
    PNG_TOOLS = [:optipng, :pngout, :advpng]
    AVAILABLE_TOOLS = JPEG_TOOLS + PNG_TOOLS
    GLOBAL_OPTIONS = [:verbose]

    # opts can be specified globally or per-tool. Global options are those available to all tools,
    # such as verbose
    # ex. {
    #       verbose: true,
    #       jpegoptim: { quality: 50 },
    #       advpng: { compress-level: 4 }
    #      }
    #
    # available global options are: :verbose
    #
    # you can use the tools options to customzie the tools that are used
    def optimize(path, opts= {})
      tools = opts[:tools] || AVAILABLE_TOOLS
      optimize_for(path, tools, opts)
      true
    end

    def pngquant(path)
      PngQuantizator::Image.new(path).quantize!
    end

    def logger
      @logger ||= Logger.new(STDERR)
    end

    def logger=(logger)
      @logger = logger
    end

    private

    def optimize_for(path, tools, opts)
      case extension(path)
        when "png", "gif" then optimize_png(path, tools, opts)
        when "jpg", "jpeg" then optimize_jpg(path, tools, opts)
      end
    end

    def extension(path)
      path.split(".").last.downcase
    end

    def extract_global_options(opts)
      opts.select { |opt| GLOBAL_OPTIONS.include?(opt) }
    end

    def optimize_png(path, tools, opts)
      global_options = extract_global_options(opts)
      OptipngRunner.new(path, global_options, opts[:optipng]).run if tools.include?(:optipng)
      PngoutRunner.new(path, global_options, opts[:pngout]).run if tools.include?(:pngout)
      AdvpngRunner.new(path, global_options, opts[:advpng]).run if tools.include?(:advpng)
    end

    def optimize_jpg(path, tools, opts)
      global_options = extract_global_options(opts)
      JpegoptimRunner.new(path, global_options, opts[:jpegoptim]).run if tools.include?(:jpegoptim)
      JpegrescanRunner.new(path, global_options, opts[:jpegrescan]).run if tools.include?(:jpegrescan)
    end
  end
end
