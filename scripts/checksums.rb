#!/usr/bin/env ruby

require 'open-uri'
require 'yaml'

versions = %w(0.2.0 0.2.1 0.2.3 0.3.0 0.3.1 0.3.2 0.4.0 0.4.1)
keepers = %w(linux_amd64)
results = { 'nomad_checksums' => {} }

class Array
  def partial_include? search
    self.each do |e|
      return true if search.include?(e.to_s)
    end
    return false
  end
end

versions.each do |v|
  url = "https://releases.hashicorp.com/nomad/#{v}/nomad_#{v}_SHA256SUMS"
  open(url) do |u|
    content = u.read
    content.each_line do |line|
      checksum, fname = line.gsub(/\s+/, ' ').strip.split(' ')
      next unless keepers.partial_include?(fname)
      results['nomad_checksums'][fname] = "sha256:#{checksum}"
    end
  end
end

# checksums_path = File.expand_path('../../defaults/checkums.yml', __FILE__)
# File.open(checksums_path, 'w') {|f| f.write results.to_yaml }

puts results.to_yaml
