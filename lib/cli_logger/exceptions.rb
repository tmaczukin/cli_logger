module CliLogger
  class CliLoggerError < RuntimeError; end

  class UnknownLogLevelError < CliLoggerError; end
end
