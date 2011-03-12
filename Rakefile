require 'bundler'
Bundler.setup :dev, :test
Bundler.require :dev, :test

require 'rake/clean'
require 'rspec/core/rake_task'


# Building

BUILD_DIR = 'build'

desc 'Builds Rollr'
task :build do
  sh 'xcodebuild'
end

CLEAN.add File.join(BUILD_DIR, '*', '*.dSYM'),
          File.join(BUILD_DIR, '*.build')

CLOBBER.add 'build'


# Testing

RSpec::Core::RakeTask.new(:spec)
