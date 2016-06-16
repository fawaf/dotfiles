#!/usr/bin/env ruby

require 'fileutils'

dotfiles_dir = File.expand_path(File.dirname(__FILE__))
Dir.chdir(dotfiles_dir)

puts "updating repo"
puts `git pull`
puts ""

puts "submodule init"
puts `git submodule init`
puts ""

puts "submodule sync"
puts `git submodule sync`
puts ""

puts "submodule update"
puts `git submodule update`
puts ""

files = Dir.glob('*')
files.each do |file|
  next if file.start_with?('README', 'LICENSE', 'setup')
  FileUtils.rm_rf("#{ENV['HOME']}/.#{file}", :verbose => true)
  FileUtils.cp_r(file, "#{ENV['HOME']}/.#{file}", :verbose => true, :remove_destination => true)
end

FileUtils.ln_s("#{ENV['HOME']}/.login", "#{ENV['HOME']}/.zlogin", :force => true, :verbose => true)
FileUtils.ln_s("#{ENV['HOME']}/.logout", "#{ENV['HOME']}/.zlogout", :force => true, :verbose => true)

custom_setup_script = 'setup-custom.rb'
if File.exist?(custom_setup_script)
  puts "=" * 88
  puts "running addition custom setup script #{custom_setup_script}"
  puts ""

  exec(custom_setup_script)
end
