require 'json'

require 'rubygems'
require 'temple'
require 'treetop'
require 'sanitize'
require 'sinatra/base'
require 'control_tower'

# It would be totally cool just to do something like "require *.rb" however
# some of the classes have subclass dependencies on other classes so the load
# order is important.

CORE_LIBS = %w{CoreExt}

TUML_LIBS = %w{
  Tuml Parser ScopeFilter BlockFilter Generator Engine Template
}

THUD_LIBS = %w{
  TemplateContext
  Post AnswerPost AudioPost ChatPost LinkPost PhotoPost QuotePost TextPost
    VideoPost
  Page AskPage CustomPage DayPage IndexPage PermalinkPage SearchPage
    SubmitPage TagPage
}

APP_LIBS = %w{
  AppController AppDelegate ArrowView DropView HTTPRequest MainWindow
    OptionsView UserTemplate WebView
}

# These arn't required here so that in the Rakefile the env. can be
# selectively loaded depeneding on what is needed.
