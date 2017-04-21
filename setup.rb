#!/usr/bin/env ruby

require 'json'
require 'slop'
require 'fileutils'

options = Slop.parse do |o|
  o.bool '-v', '--verbose', 'verbose mode'
  o.bool '-e', '--dev', 'dev mode'
  o.string '-c', '--config', 'config file'
  o.on '-h', '--help', 'halp please' do
    puts o
    exit 0
  end
end

dotfiles_dir = File.expand_path(File.dirname(__FILE__))

dev = options.dev?
verbose = options.verbose?

config_file = if options.config?
                options[:config]
              else
                "#{dotfiles_dir}/config.json"
              end

if dev
  home_dir = "/tmp"
else
  home_dir = ENV['HOME']
end

def divider
  puts "=" * 85
end

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

config = JSON.parse(File.read(config_file))
puts config if verbose

entries = Dir.glob('*')
entries.each do |entry|
  next if entry.start_with?('README', 'LICENSE', 'setup', 'config', 'Makefile')

  dest = "#{home_dir}/.#{entry}"
  puts "dest is #{dest}" if verbose

  if config["append"].include?(entry)
    Dir.glob("#{entry}/*").each do |e|
      FileUtils.copy(e, dest, :verbose => verbose)
    end
  else
    puts "removing #{dest}" if verbose
    FileUtils.rm_rf(dest, :verbose => verbose)

    puts "copying entry #{entry} to #{dest}" if verbose
    FileUtils.copy_entry(entry, dest)
  end
end

custom_setup_script = 'setup-custom.rb'
if File.exist?(custom_setup_script)
  divider
  puts "running addition custom setup script #{custom_setup_script}"
  puts ""

  exec(custom_setup_script)
end
