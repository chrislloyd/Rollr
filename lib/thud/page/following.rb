module Thud
  class Page

    # Rendered if you're following other blogs.
    block 'Following' do
      false
    end

    # Rendered for each blog you're following.
    block 'Followed'

    # The username of the blog you're following.
    tag 'FollowedName'

    # The title of the blog you're following.
    tag 'FollowedTitle'

    # The URL for the blog you're following.
    tag 'FollowedURL'

    # Portrait photo URL for the blog you're following.
    PORTRAIT_SIZES.each do |n|
      tag "FollowedPortraitURL-#{n}"
    end

  end
end
