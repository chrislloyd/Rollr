class AppDelegate
  attr_accessor :app_controller

  def applicationDidFinishLaunching notification
    puts 'less awesome'
    self.app_controller = AppController.new
    puts 'awesome'
  end

  def applicationWillTerminate notification
    app_controller.stop_server!
  end

  def application application, openFile:file
    puts application
    puts file
  end

end
