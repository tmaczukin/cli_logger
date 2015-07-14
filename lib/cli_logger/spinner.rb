module CliLogger
  # Spinner class
  #
  class Spinner
    def initialize
      @chars = %w( + - - - )
      @step = 0.095
    end

    def start
      stop
      sleep @step

      @thread = Thread.new { spin }
    end

    def stop
      return unless @thread
      return if @thread[:done]

      @thread[:done] = true
      sleep @step / (@chars.count - 1)
      clear_line
    end

    def spin
      $stdout.sync = true
      Thread.current[:done] = false
      until Thread.current[:done]
        clear_line
        print @chars.join.green
        @chars.unshift @chars.pop
        sleep @step
      end
    end

    def clear_line
      width = @chars.count

      print "\r"
      print ' ' * width
      print "\r"
    end
  end
end
