framework 'Cocoa'

# The NSApplication documentation says that NSApplicationMain is implemented like:
#   void NSApplicationMain(int argc, char *argv[]) {
#     [NSApplication sharedApplication];
#     [NSBundle loadNibNamed:@"myMain" owner:NSApp];
#     [NSApp run];
#   }
#
# Everything after the line below and NSApp.run is basically replacing loading
# a Nib from disk.

# Triggers the lazy initialization of NSApp
NSApplication.sharedApplication

__DIR__ = NSBundle.mainBundle.resourcePath.fileSystemRepresentation

# Require Standard Library
require 'json'

$LOAD_PATH.unshift File.join(__DIR__, 'lib')

require 'rubygems'



#%w( rubygems json rest_client control_tower sinatra/base tuml thud ).each do |lib|
#  puts lib
#  puts Benchmark.measure(lib) {require lib}
#end

#r equire 'core_ext'

# Loads all the Ruby classes
# Dir[File.join(__DIR__, '*.{rb,rbo}')].
#   map {|path| File.basename(path, File.extname(path))}.
#   uniq.
#   reject {|file| file == 'main' || file == 'core_ext'}.
#   each {|file| require file}

# require 'AppDelegate'

# NSApp.delegate = AppDelegate

puts 'shawesome'

# NSApp.run
