#!/usr/bin/env ruby

require 'fileutils'

files = Dir.glob('*')
files.each do |file|
  next if file.start_with?('README', 'LICENSE', 'setup')
  FileUtils.cp_r(file, "#{ENV['HOME']}/.#{file}", :verbose => true, :remove_destination => true)
end
