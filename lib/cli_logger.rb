require 'colorize'

require 'cli_logger/exceptions'
require 'cli_logger/version'

# CliLogger module
#
module CliLogger
  autoload :Logger,      'cli_logger/logger'
  autoload :Spinner,     'cli_logger/spinner'
  autoload :ProgressBar, 'cli_logger/progress_bar'

  extend Logger
end
