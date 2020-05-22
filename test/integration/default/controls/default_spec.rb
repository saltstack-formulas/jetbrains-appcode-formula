# frozen_string_literal: true

title 'appcode archives profile'

control 'appcode archive' do
  impact 1.0
  title 'should be installed'

  describe file('/etc/defaults/appcode.sh') do
    it { should exist }
  end
  # describe file('/usr/local/jetbrains/appcode-*/bin/appcode.sh') do
  #   it { should exist }
  # end
  describe file('/usr/local/bin/appcode') do
    it { should exist }
  end
end
