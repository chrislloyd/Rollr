class Symbol

  def to_selector
    "#{self}:".to_sym
  end

end

class NSObject

  # Usage:
  #   bind 'Yo', :stop_server, from: obj
  def bind name, method, opts={}
    NSNotificationCenter.defaultCenter.addObserver self,
      selector: method.to_selector,
      name: name,
      object: opts[:from]
  end

  # Usage:
  #   trigger 'wassup'
  def trigger name, sender=nil
    NSNotificationCenter.defaultCenter.postNotificationName name,
      object: sender || self
  end

  # Defers the method to be called until the next event pass
  def defer method, arg=nil
    performSelector method.to_selector, withObject:arg, afterDelay:0
  end

end

class ControlTower::RackSocket
  def open?
    @status == :open
  end
end
