require 'spec_helper'

feature 'User following' do
  scenario 'user follows and unfollows someone' do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    # Fabricate(:review, user: alice, video: video)
    Fabricate(:review, user: bob, video: video)

    sign_in(alice)
    click_on_video_on_home_page(video)

    click_link bob.full_name
    click_link 'Follow'
    expect(page).to have_content(alice.full_name)

    unfollow(bob)
    expect(page).not_to have_content(bob.full_name)
  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end

end
