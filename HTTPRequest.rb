class HTTPRequest

  attr_accessor :url, :payload, :callback

  def self.start url, &callback
    new(url, &callback).tap do |o|
      o.start!
    end
  end

  def initialize url, &callback
    self.url, self.callback = url, callback
    self.payload = NSMutableData.data
  end

  def start!
    NSURLConnection.alloc.initWithRequest NSURLRequest.requestWithURL(url),
                                delegate: self
  end

  # Handles redirects
  def connection connection, willSendRequest: request, redirectResponse: redirectResponse
    self.url = request.URL
    request
  end

  def connection connection, didReceiveResponse: response
    payload.length = 0
  end

  def connection connection, didReceiveData: data
    payload.appendData data
  end

  def connection connection, didFailWithError: error
    NSAlert.alertWithError(error).runModal
  end

  def connectionDidFinishLoading connection
    callback.call payload
  end

end
