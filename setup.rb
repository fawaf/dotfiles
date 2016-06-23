#!/usr/bin/env ruby

require 'fileutils'

def divider
  puts "=" * 85
end

dotfiles_dir = File.expand_path(File.dirname(__FILE__))
Dir.chdir(dotfiles_dir)

puts "updating repo"
puts `git pull`
divider

puts "submodule init"
puts `git submodule init`
divider

puts "submodule sync"
puts `git submodule sync`
divider

puts "submodule update"
puts `git submodule update`
divider

files = Dir.glob('*')
files.each do |file|
  next if file.start_with?('README', 'LICENSE', 'setup')

  dest = "#{ENV['HOME']}/.#{file}"

  FileUtils.rm_rf(dest, :verbose => true)

  puts "copying entry #{file} to #{dest}"
  FileUtils.copy_entry(file, dest)
end

custom_setup_script = 'setup-custom.rb'
if File.exist?(custom_setup_script)
  divider
  puts "running addition custom setup script #{custom_setup_script}"
  puts ""

  exec(custom_setup_script)
end
