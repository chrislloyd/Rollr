framework 'Cocoa'

# Starts the app icon bouncing
NSApplication.sharedApplication
require 'boot'

(CORE_LIBS + TUML_LIBS + THUD_LIBS + APP_LIBS).
  each {|lib| require lib}

NSApp.delegate = AppDelegate.new

NSApp.run
