
describe file('/var/lib/nomad') do
  it { should be_directory }
  it { should be_owned_by('nomad') }
  it { should be_grouped_into 'nomad' }
  its('mode') { should cmp '0750' }
end

describe file('/etc/nomad') do
  it { should be_directory }
  it { should be_owned_by('root') }
  it { should be_grouped_into 'nomad' }
  its('mode') { should cmp '0750' }
end

describe file('/etc/nomad/config.json') do
  it { should be_file }
  it { should be_owned_by('nomad') }
  it { should be_grouped_into 'nomad' }
  its('mode') { should cmp '0640' }
  its('content') { should include('"data_dir": "/var/lib/nomad"') }
  its('content') { should include('"server": {') }
  its('content') { should include('"bootstrap_expect": 1') }
  its('content') { should_not include('client') }
end

describe service('nomad') do
  it { should be_enabled }
  it { should be_running }
end

[4646, 4647, 4648].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command('curl --fail -s http://localhost:4646/v1/status/leader') do
  its('stdout') { should match /"\d+\.\d+\.\d+\.\d+\:\d+"/ }
  its('exit_status') { should eq 0 }
end

describe command('/usr/local/bin/nomad version') do
  its('exit_status') { should eq 0 }
end
