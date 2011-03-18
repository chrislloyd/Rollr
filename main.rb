framework 'Cocoa'

# Starts the app icon bouncing
NSApplication.sharedApplication

require 'json'

require 'rubygems'
require 'temple'
require 'treetop'
require 'sanitize'
require 'sinatra/base'
require 'control_tower'

%w{

  CoreExt

  Tuml Parser ScopeFilter BlockFilter Generator Engine Template

  TemplateContext
  Post AnswerPost AudioPost ChatPost LinkPost PhotoPost QuotePost TextPost
    VideoPost
  Page AskPage CustomPage DayPage IndexPage PermalinkPage SearchPage
    SubmitPage TagPage

  AppController AppDelegate ArrowView DropView HTTPRequest MainWindow
    OptionsView UserTemplate WebView

}.each {|lib| require lib}

NSApp.delegate = AppDelegate.new

NSApp.run
