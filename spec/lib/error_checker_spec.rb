require 'rails_helper'
require 'sample_data'

RSpec.describe ErrorChecker do
  describe '.check_for_errors' do
    it 'warns response[\'error\']' do
      expect { ErrorChecker.check_for_errors(error_response, 'AAFL') }.to output("AAFL ----- Requested entity does not exist.\n").to_stderr
    end
  end
end
