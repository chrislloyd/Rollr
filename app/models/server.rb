module Rollr
  class Server < Sinatra::Base

    # Hack for ControlTower
    def self.app
      self
    end

    TAG_EXCUSES = [
      "missed the bus",
      "went AWOL",
      "dropped the ball",
      "got bumped",
      "was refused entry",
      "slept in"
    ]

    helpers do

      def tuml scope
        render :tuml, File.read(template), locals: {
          page: scope
        }
      end

      def data
        @data = JSON.parse File.read(settings.data_path)
      end

      def template
        settings.template_path
      end

      def asset name
        File.read File.join(Rollr.dir, 'rollr', 'assets', name)
      end

    end


    before do
      @root = Thud::Page.new nil, data
    end

    get '/' do
      tuml Thud::Pages::Index.new(@root)
    end

    get '/page/:n' do |n|
      tuml Thud::Pages::Index.new(@root, n)
    end

    get '/post/:id' do |id|
      tuml Thud::Pages::Permalink.new(@root, id)
    end

    get '/tagged/:tag' do |tag|
      tuml Thud::Pages::Tag.new(@root, tag)
    end

    get '/search/:query' do |query|
      tuml Thud::Pages::Search.new(@root, query)
    end

    get '/ask' do
      tuml Thud::Pages::Ask.new(@root, data)
    end

    get '/submit' do
      tuml Thud::Pages::Submit.new(@root, data)
    end

    get Thud::Page::RSS_PATH do
      # TODO
    end

    # Some themes use the API to get post information via. JS.
    get '/api/*' do
      redirect @root.absolute_url('api', *params[:splat])
    end

    # If a static file exists, it gets served up first.
    Thud::Context::PORTRAIT_SIZES.each do |n|
      get "/portrait_url_#{n}.gif" do
        redirect "http://assets.tumblr.com/images/default_avatar_#{n}.gif"
      end
    end

    get '/favicon.ico' do
      404
    end


    # private
    # keep ur dirty mitts out!

    get '/__rollr__.css' do
      content_type :css
      asset('rollr.css')
    end

    error Thud::Context::NotImplemented do
      erb asset('not-implemented.html.erb'), layout: asset('layout.html.erb'),
                                             locals: {
                                               tag: env['sinatra.error'].message
                                             }
    end

    error Errno::ENOENT do
      erb asset('data-not-found.html.erb'), layout: asset('layout.html.erb'),
                                            locals: {
                                              path: settings.data_path
                                            }
    end

  end
end
