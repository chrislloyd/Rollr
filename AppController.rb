require 'fileutils'

class AppController
  attr_accessor :template
  attr_accessor :window

  HOST = 'localhost'
  PORT = 7051

  def initialize
    # self.template = Rollr::Template.new

    # template.site = 'chrislloyd.tumblr.com'

    render_main

    # bind 'DropViewConcludedDrag', :set_path, from: drop_view
    # bind 'Updated:Path', :show_file, from:template
    #
    # bind 'Updated', :attempt_start, from:template
  end

  def render_main
    window.title = 'Rollr'
    window.orderFrontRegardless
    window.contentView.addSubview drop_view
  end

  def set_path note
    template.path = note.object.path_url
  end

  def show_file note
    drop_view.show_file note.object.path
  end

  def attempt_start note
    # return if template.incomplete?
    puts 'attempting to start'
    p @template

    p @template.path
    p @template.site
    p @template.data_path

    start_server!
  end

  def preview_clicked sender
    puts 'Preview Clicked'
  end

  def windowWillClose notification
    NSApp.defer :terminate
  ensure

    puts @socket.instance_variable_get('@status')
    stop_server!
    true
  end

  def start_server!
    Rollr::Server.set template_path: @template.path,
      views: @template.view_path,
      public: @template.public_path,
      environment: 'development',
      data_path: @template.data_path

    @socket = ControlTower::RackSocket.new HOST, PORT, Rollr::Server, false
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

  # def server_running?
  #   @socket and @socket.open? #) or @socket_thread.alive?
  # end

  def window
    @window ||= MainWindow.alloc.initWithContentRect(
      [200,300,300,500],
      styleMask: NSTitledWindowMask|NSClosableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false
    ).tap {|w|
      w.delegate = self
      puts 'started window'
    }
  end

  def drop_view
    @drop_view ||= DropView.alloc.initWithRect(
      [0, 0, 300, 100]
    )
  end

end