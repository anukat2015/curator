require 'rails_helper'
require 'sample_data'

RSpec.describe ErrorChecker do
  describe '.check_for_errors' do
    it 'warns response[\'error\']' do
      expect { ErrorChecker.new(response: error_response, ticker: 'AAFL').check_for_errors }.to output("AAFL ----- Requested entity does not exist.\n").to_stderr
    end

    it 'warns response[\'errors\']' do
      expect { ErrorChecker.new(response: errors_response, ticker: 'NOTATICKER').check_for_errors }.to output("NOTATICKER ----- Something's wrong.\n").to_stderr
    end

    it 'warns non Hash responses' do
      expect { ErrorChecker.new(response: 'Not a hash', ticker: 'NOTATICKER').check_for_errors }.to output("Not a hash\n").to_stderr
    end

    it 'calls slow_down when requests are being made too quickly' do
      expect { ErrorChecker.new(response: 'too quickly', ticker: 'NOTATICKER').check_for_errors }.to output("Pausing for 5 seconds...\nResuming...\n").to_stdout
    end
  end

  describe '.slow_down' do
    it 'alerts the user that the app is pausing its requests' do
    end
  end
end
