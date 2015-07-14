describe CliLogger do
  before do
    CliLogger.current_level = :debug
    CliLogger.set_options(:disable_spinner, :disable_progress_bar)
  end

  it 'has debug logging method' do
    expect { CliLogger.debug('message') }.to output(/^\s*\[\?\] message/).to_stdout
  end

  it 'has info logging method' do
    expect { CliLogger.info('message') }.to output(/^\s*\[\*\] message/).to_stdout
  end

  it 'has warning logging method' do
    expect { CliLogger.warning('message') }.to output(/^\s*\[-\] message/).to_stdout
  end

  it 'has error logging method' do
    expect { CliLogger.error('message') }.to output(/^\s*\[!\] message/).to_stdout
  end

  context 'with existing log level' do
    it 'has log logging method' do
      expect { CliLogger.log(:info, 'message') }.to output(/^\s*\[\*\] message/).to_stdout
    end
  end

  context 'without existing log level' do
    it 'raise exception for log logging method' do
      expect { CliLogger.log(:non_existing, 'message') }.to raise_error(CliLogger::UnknownLogLevelError)
    end
  end

  it 'should not print messages with log_level higher than current_level' do
    CliLogger.current_level = :warning

    expect(CliLogger.error('message')).not_to be_empty
    expect(CliLogger.warning('message')).not_to be_empty
    expect(CliLogger.info('message')).to be_nil
  end

  context 'sublogs' do
    subject do
      lambda do
        CliLogger.info('message') do
          CliLogger.debug('submessage')
        end
      end
    end

    it 'should add sublogs ended with DONE wneh block given' do
      expect { subject.call }.to output(/^\s*\[\*\] DONE/m).to_stdout
    end
  end
end
