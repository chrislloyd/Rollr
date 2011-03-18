class IndexPage < Page

  # TODO Allow options
  POSTS_PER_PAGE = 10

  attr_accessor :number

  def initialize args={}
    super
    self.number = args[:number] || 1
  end

  block 'IndexPage' do
    true
  end

  # TODO: Pagination
  block 'Posts' do
    # start_index = (POSTS_PER_PAGE * page) - 1
    # end_index = [start_index + POSTS_PER_PAGE, data['posts'].length].min
    data['posts'].map do |post|
      Post.for prototype: self, post: post
    end
  end

end
