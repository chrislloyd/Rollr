module Thud
  class Page

    # Rendered on additional public group blogs.
    block 'GroupMembers'

    # Rendered for each additional public group blog member.
    block 'GroupMember'

    tag 'GroupMemberName'
    # The username of the member's blog.

    # The title of the member's blog.
    tag 'GroupMemberTitle'

    # The URL for the member's blog.
    tag 'GroupMemberURL'

    # Portrait photo URL for the member.
    PORTRAIT_SIZES.each do |n|
      tag "GroupMemberPortraitURL-#{n}"
    end

  end
end
