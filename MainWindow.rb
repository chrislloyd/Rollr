class MainWindow < NSWindow

  WIDTH = 300#px
  HEIGHT = 260#px

  def self.from_top px
    HEIGHT - px
  end

end
