require 'fileutils'

class AppController
  attr_accessor :template

  HOST = 'localhost'
  PORT = 7051

  def initialize
    self.template = UserTemplate.new

    window.title = 'Rollr'
    window.contentView.addSubview drop_view
    window.contentView.addSubview options_view
    window.contentView.addSubview spinner
    window.contentView.addSubview preview_button
    
    NSApp.mainMenu = NSMenu.alloc.initWithTitle ''
    
    NSApp.mainMenu.addItemWithTitle 'Foobar', action: :foo.to_selector, keyEquivalent: ''
    
    NSApp.helpMenu
    
    puts 'awse'
    

    bind :changeTemplatePath, from: drop_view, named: 'Changed'
    bind :changeTemplateSite, from: options_view.site_field, named: 'Changed'

    bind :finishedFetchingData, from: template, named: 'DataFetched'


    bind :attemptStartServer, from: drop_view, named: 'Changed'
    bind :attemptStartServer, from: options_view.site_field, named: 'Changed'
    bind :attemptStartServer, from: template, named: 'DataFetched'

    window.center
    window.makeKeyAndOrderFront self
  end

  def windowWillClose notification
    NSApp.defer :terminate
  end

  def changeTemplatePath notification
    template.path = notification.object.path_url
    drop_view.show_file template.path
  end

  def changeTemplateSite notification
    template.site = notification.object.stringValue

    if not template.data_exists?
      preview_button.enabled = false
      spinner.startAnimation self
      spinner.hidden = false
      template.fetch_and_cache_data!
    end
  end

  def finishedFetchingData notification
    spinner.hidden = true
    spinner.stopAnimation self
  end

  def attemptStartServer notification
    if template.complete?
      preview_button.enabled = true
      start_server!
    end
  end

  def openPreview sender
    NSWorkspace.sharedWorkspace.openURL NSURL.alloc.initWithString "http://#{HOST}:#{PORT}"
  end


  # Server Controls

  def start_server!
    WebView.set template_path: @template.path,
      views: @template.view_path,
      public: @template.public_path,
      environment: :development,
      data_path: @template.data_path

    @socket = ControlTower::RackSocket.new HOST, PORT, WebView, false
    @socket_thread = Thread.new {@socket.open}
  end

  def stop_server!
    if server_running?
      @socket.close
      @socket_thread.join
    end
  end

  def restart_server!
    stop_server!
    start_server!
  end

private

  def server_running?
    @socket and @socket.open?
  end


  # Views

  def window
    @window ||= MainWindow.alloc.initWithContentRect([0, 0, MainWindow::WIDTH, MainWindow::HEIGHT],
      styleMask: NSTitledWindowMask|NSClosableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false
    ).tap {|w|
      w.delegate = self
    }
  end

  def drop_view
           # margin + text + pad + icon + margin
    height = 22 + 12 + 12 + 80 + 22
    @drop_view ||= DropView.alloc.initWithFrame([0, MainWindow.from_top(height), MainWindow::WIDTH, height])
  end

  def options_view
    height = 22 + 22 + 22
    @options_view ||= OptionsView.alloc.initWithFrame([
      0, MainWindow.from_top(drop_view.frame.size.height + height),
      MainWindow::WIDTH, height
    ])
  end

  def spinner
    @spinner ||= NSProgressIndicator.alloc.initWithFrame([
      MainWindow::WIDTH - preview_button.frame.size.width - (22 / 2) - 16, 22 + 4,
      16, 16
    ]).tap {|spinner|
      spinner.style = NSProgressIndicatorSpinningStyle
      spinner.controlSize = NSSmallControlSize
      spinner.hidden = true
    }
  end

  def preview_button
    # Buttons seem to need an extra 2px for the shadow
    width = 90#px
    @preview_button ||= NSButton.alloc.initWithFrame([
        MainWindow::WIDTH - width - 5, 22 - 2,
        width, 22 + 2
      ]).tap {|button|
        button.title = 'Preview'
        button.bezelStyle = NSRoundedBezelStyle
        button.acceptsFirstResponder = false
        button.enabled = false
        button.target = self
        button.action = :openPreview.to_selector
      }
  end

end
