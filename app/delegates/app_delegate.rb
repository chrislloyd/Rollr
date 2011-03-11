puts 'loaded app delegate'

class AppDelegate
  attr_accessor :app_controller

  def applicationDidFinishLaunching notification
    
    NSWindow.alloc.initWithContentRect(
                                       [200,300,300,100],
                                       styleMask:NSTitledWindowMask|NSClosableWindowMask,
                                       backing: NSBackingStoreBuffered,
                                       defer: false
                                       ).tap do |w|
      w.title = "MacRuby: The Definitive Guide"
      w.delegate = AppController
      
      w.contentView.addSubview(
                               NSButton.alloc.initWithFrame([60, 10, 180, 80]).tap do |b|
                               b.bezelStyle = 4
                               b.title      = 'Hello Ruby Oceania!'
                               b.target     = AppDelegate
                               b.action     = 'say_hello:'
                               end
                               )
      w.orderFrontRegardless
    end

    
    
    puts 'awesome, loaded'
  end

  def applicationWillTerminate notification
    app_controller && app_controller.stop_server!
  end

  def application application, options={}
    puts application
    puts options[:openFile]
  end

end
