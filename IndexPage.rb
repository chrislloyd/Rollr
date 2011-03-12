class IndexPage < TemplateContext

  # TODO Allow options
  POSTS_PER_PAGE = 10

  attr_accessor :page

  def initialize prototype, page=1
    super prototype
    self.page = page.to_i
  end

  block 'IndexPage' do
    true
  end

  # TODO: Pagination
  block 'Posts' do
    # start_index = (POSTS_PER_PAGE * page) - 1
    # end_index = [start_index + POSTS_PER_PAGE, data['posts'].length].min
    data['posts'].map do |post|
      Post.for self, post
    end
  end

end
