class Symbol

  def to_selector
    "#{self}:".to_sym
  end

end

class NSObject

  # Usage:
  #   bind :stop_server, from: obj, named: 'Yo'
  def bind method, opts
    NSNotificationCenter.defaultCenter.addObserver self,
      selector: method.to_selector,
      name: opts[:named],
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

class NSResponder

  def acceptsFirstResponder= val
    (@acceptsFirstResponder = val).tap do
      instance_eval do
        def acceptsFirstResponder
          @acceptsFirstResponder
        end
        self
      end
    end
  end

end

# TODO LONGTERM Contribute methods back to ControlTower.
#   Really, the only use case for ControlTower is embedded inside applications
#   so it makes sense for it to have great start/stop/querying.
class ControlTower::RackSocket
  def open?
    @status == :open
  end
end

# BUG Macruby
class Temple::Filter
  def self.default_options
    {}
  end
end

class NSURL

  def fetch &callback
    HTTPRequest.start self, &callback
  end

end
