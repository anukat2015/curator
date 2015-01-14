require 'rails_helper'
require 'sample_data'

RSpec.describe ErrorChecker do
  describe '.check_for_errors' do
    it 'warns about errors' do
      #expect { ErrorChecker.check_for_errors() }.to output().to_stderr
    end
  end
end
