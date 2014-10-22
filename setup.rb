#!/usr/bin/env ruby

require 'fileutils'

dotfiles_dir = "#{ENV['HOME']}/.dotfiles"

Dir.chdir(dotfiles_dir)
`git submodule init`
`git submodule sync`
`git submodule update`

files = Dir.glob('*')
files.each do |file|
  next if file.start_with?('README', 'LICENSE', 'setup')
  FileUtils.cp_r(file, "#{ENV['HOME']}/.#{file}", :verbose => true, :remove_destination => true)
end
`ln -sfv ~/.login ~/.zlogin`
`ln -sfv ~/.logout ~/.zlogout`
