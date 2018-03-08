#!/usr/bin/env ruby

require 'json'
require 'slop'
require 'fileutils'

options = Slop.parse do |o|
  o.bool '-f', '--force', 'do not force commands'
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
force = options.force?

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

def divider(index = 1, times = 85)
  puts "=" * times if index > 0
end

Dir.chdir(dotfiles_dir)

print "updating repo... "
pull = `git pull &> /dev/stdout`
puts "done."
puts pull if verbose
divider if verbose

print "submodule init... "
init = `git submodule init`
puts "done."
puts init if verbose
divider if verbose

print "submodule sync... "
sync = `git submodule sync`
puts "done."
puts sync if verbose
divider if verbose

print "submodule update... "
update = `git submodule update`
puts "done."
puts update if verbose
divider if verbose

config = JSON.parse(File.read(config_file))
puts config if verbose

print "setting up dotfiles... "
entries = Dir.glob('*').sort
entries.each_with_index do |entry,index|
  next if entry.start_with?('README', 'LICENSE', 'setup', 'config.json', 'Makefile', 'update-')
  divider(index) if verbose

  dest = "#{home_dir}/.#{entry}"
  puts "dest is #{dest}" if verbose

  puts "entry is #{entry}" if verbose
  if config["append"].include?(entry)
    FileUtils.mkdir_p(entry) unless Dir.exists?(entry)
    Dir.glob("#{entry}/*").each do |e|
      puts "copying entry #{e} to #{dest}" if verbose
      FileUtils.cp_r(e, dest, :verbose => verbose)
    end
  else
    puts "removing #{dest}" if verbose
    FileUtils.rm_rf(dest, :verbose => verbose)

    puts "copying entry #{entry} to #{dest}" if verbose
    FileUtils.copy_entry(entry, dest)
  end
end
puts "done."

custom_setup_script = 'setup-custom.rb'
if File.exist?(custom_setup_script)
  divider
  puts "running custom setup script #{custom_setup_script}"
  puts ""

  exec(custom_setup_script, verbose.to_s, force.to_s)
end
