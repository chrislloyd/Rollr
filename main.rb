framework 'Cocoa'

# Initialises instance of NSApplication (NSApp) and bounces the app icon.
NSApplication.sharedApplication

__DIR__ = NSBundle.mainBundle.resourcePath.fileSystemRepresentation

require 'rubygems'
require 'temple'
require 'sinatra/base'
require 'control_tower'

%w{CoreExt

  Parser ScopeFilter BlockFilter Generator Engine Template

  TemplateContext
  Post AnswerPost AudioPost ChatPost LinkPost PhotoPost QuotePost TextPost
    VideoPost
  Page AskPage CustomPage DayPage IndexPage PermalinkPage SearchPage
    SubmitPage TagPage

  AppController AppDelegate DropIconView DropView MainWindow WebView
}.each {|lib| require lib}

NSApp.setActivationPolicy NSApplicationActivationPolicyRegular

NSApp.delegate = AppDelegate
NSApp.activateIgnoringOtherApps true

NSApp.run
