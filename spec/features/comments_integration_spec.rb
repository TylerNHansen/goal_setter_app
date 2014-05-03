require 'spec_helper'

feature 'comments' do

  it 'user show page has new comment form' do
    sign_up('user_test')
    expect(page).to have_content("Add a Comment")
  end

  it 'goal show page has a new comment form' do
    create_new_goal
    expect(page).to have_content("Add a Comment")
  end

  %w(goal user).each do |word|
    it "makes a comment on a #{word}" do
      create_new_comment_on(word)
      expect(page).to have_content('test comment please ignore')
      # comment is on page

      if current_path.match('goal')
        expect(page).to have_content('Make a million dollars')
      elsif current_path.match('user')
        expect(page).to have_content('test_user')
      else
        fail 'Invalid path reached'
      end
    end
  end

  it 'user can remove his/her own comment' do
    create_new_comment_on('goal')
    expect(page).to have_button('Remove Comment')
    click_button('Remove Comment')
    expect(page).to_not have_content('test comment please ignore')
  end

  it "user can't remove comments they don't own" do
    create_new_comment_on('goal')
    path = current_path
    sign_out
    sign_up('other_user')
    visit path
    expect(page).to_not have_button('Remove Comment')
  end

  %w(goal user).each do |word|
    it "user can remove comments on his/her own #{word}" do
      comment_with_other_user(word)
      expect(page).to have_button('Remove Comment')
    end
  end

end