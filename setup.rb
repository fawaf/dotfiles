#!/usr/bin/env ruby

require 'fileutils'

dotfiles_dir = File.expand_path(File.dirname(__FILE__))
Dir.chdir(dotfiles_dir)

`git pull`
`git submodule init`
`git submodule sync`
`git submodule update`

files = Dir.glob('*')
files.each do |file|
  next if file.start_with?('README', 'LICENSE', 'setup')
  FileUtils.rm_rf("#{ENV['HOME']}/.#{file}", :verbose => true)
  FileUtils.cp_r(file, "#{ENV['HOME']}/.#{file}", :verbose => true, :remove_destination => true)
end
FileUtils.ln_s("#{ENV['HOME']}/.login", "#{ENV['HOME']}/.zlogin", :force => true, :verbose => true)
FileUtils.ln_s("#{ENV['HOME']}/.logout", "#{ENV['HOME']}/.zlogout", :force => true, :verbose => true)
