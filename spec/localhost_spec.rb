require 'spec_helper'

describe 'localhost' do
  describe file('/etc/passwd') do
    it { should be_file }
  end
end
