class WebView < Sinatra::Base

  # Needed for ControlTower
  def self.app
    self
  end

  helpers do

    def tuml *args
      render :tuml, *args
    end

    def template
      settings.template_path
    end

    def data
      JSON.parse File.read(settings.data_path)
    end

    def asset name
      File.join NSBundle.mainBundle.resourcePath.fileSystemRepresentation, name
    end

  end


  before do
    @root = Page.new data
  end

  get '/' do
    tuml template, :scope => IndexPage.new(@root)
  end

  get '/page/:n' do |n|
    tuml IndexPage.new(@root, n)
  end

  get '/post/:id' do |id|
    tuml PermalinkPage.new(@root, id)
  end

  get '/tagged/:tag' do |tag|
    tuml TagPage.new(@root, tag)
  end

  get '/search/:query' do |query|
    tuml SearchPage.new(@root, query)
  end

  get '/ask' do
    tuml AskPage.new(@root, data)
  end

  get '/submit' do
    tuml SubmitPage.new(@root, data)
  end

  get Page::RSS_PATH do
    # TODO
  end

  # Some themes use the API to get post information via. JS.
  get '/api/*' do
    redirect @root.absolute_url('api', *params[:splat])
  end

  # If a static file exists, it gets served up first.
  Page::PORTRAIT_SIZES.each do |n|
    get "/portrait_url_#{n}.gif" do
      redirect "http://assets.tumblr.com/images/default_avatar_#{n}.gif"
    end
  end

  get '/favicon.ico' do
    404
  end

# private

  get '/__rollr__.css' do
    content_type :css
    File.read asset('rollr.css')
  end

end
