class AppDelegate
  attr_accessor :app_controller

  def applicationDidFinishLaunching notification
    self.app_controller = AppController.new
  end

  def applicationWillTerminate notification
    app_controller.stop_server!
  end

end
