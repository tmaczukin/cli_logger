module CliLogger
  # ProgressBar class
  #
  class ProgressBar
    def initialize(spinner)
      @spinner = spinner
      @visible = false
      @width = 40
    end

    def progress(percent)
      @spinner.stop if @spinner
      @visible = true
      $stdout.sync = true

      raise InvalidProgressValueError, percent if percent < 0 || percent > 1

      @percent = percent

      print prepare_bar
    end

    def hide
      $stdout.sync = true
      @visible = false

      clear_line
      sleep 0.1
    end

    def clear_line
      width = @width + 10

      print "\r"
      print ' ' * width
      print "\r"
    end

    private

    def prepare_bar
      clear_line

      progress = (@percent * @width).floor
      progress_trace = '=' * progress
      progress_bg = '-' * (@width - progress)

      percent = @percent * 100

      "[#{progress_trace}#{progress_bg}] ".green + ('%5.2f%%'.green.bold % percent)
    end
  end
end
