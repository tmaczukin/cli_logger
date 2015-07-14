module CliLogger
  # Logger module
  #
  module Logger
    # rubocop:disable Style/AccessorMethodName
    def set_options(*args)
      @options = args
    end
    # rubocop:enable Style/AccessorMethodName

    def method_missing(name, *args, &block)
      log(name.to_sym, *args, &block) if levels.key?(name.to_sym)
    end

    def log(log_level, message)
      validate_level(log_level)
      return unless levels[log_level] <= current_level

      message = log_message(log_level, message)
      if block_given?
        sublog do
          yield progress_bar
        end
        message += log_message(log_level, 'DONE')
      end

      message
    end

    def current_level
      @current_level ||= levels[:info]
    end

    def current_level=(value)
      validate_level(value)
      @current_level = levels[value]
    end

    def levels
      {
        error: 0,
        warning: 1,
        info: 2,
        debug: 3
      }
    end

    private

    def validate_level(log_level)
      raise UnknownLogLevelError, log_level unless levels.key?(log_level)
    end

    def log_message(log_level, message)
      progress_bar.clear_line if progress_bar

      message = colorize(log_level, "#{prefix(log_level)}#{message}")
      puts message

      message
    end

    def prefix(log_level)
      "#{nesting_prefix}[#{prefixes[log_level]}] "
    end

    def prefixes
      {
        error:   '!',
        warning: '-',
        info:    '*',
        debug:   '?'
      }
    end

    def nesting_prefix
      level = @nesting_level || 0
      ' ' * level * 2
    end

    def colorize(log_level, message)
      return message unless colors[log_level]
      message.colorize(colors[log_level])
    end

    def colors
      {
        error: { color: :white, background: :red, mode: :bold },
        warning: { color: :yellow, mode: :bold },
        info: {},
        debug: { color: :light_cyan }
      }
    end

    def sublog
      add_nesting
      spinner.start if spinner

      yield

      spinner.stop if spinner
      progress_bar.hide if progress_bar
      sub_nesting
    end

    def add_nesting
      @nesting_level ||= 0
      @nesting_level += 1
      @nesting_level
    end

    def sub_nesting
      @nesting_level -= 1
      @nesting_level = 0 if @nesting_level < 0
      @nesting_level
    end

    def progress_bar
      @progress_bar ||= ProgressBar.new(spinner) unless options.include?(:disable_progress_bar)
    end

    def spinner
      @spinner ||= Spinner.new unless options.include?(:disable_spinner)
    end

    def options
      @options ||= []
    end
  end
end
