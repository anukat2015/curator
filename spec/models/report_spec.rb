require 'rails_helper'

RSpec.describe Report, :type => :model do
  it 'can be created' do
    report = Report.create!
    expect(report).to be_an_instance_of(Report)
  end

  it 'accepts a name attribute' do
    report = Report.create!(name: 'Acme Corporation')
    expect(report.name).to equal('Acme Corporation')
  end
end
