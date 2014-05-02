require 'spec_helper'

feature "the signup process" do

  before :each do
    visit new_user_url

  end

  it "has a new user page" do
    expect(page).to have_content('Sign Up')

  end

  feature "signing up the user" do
    before :each do
      sign_up('test_user')
    end

    it "shows username on the page" do
      expect(page).to have_content('test_user')
    end

  end

end

feature 'logging out' do


  it 'begins logged out' do
    visit root_url
    expect(page).to_not have_button('Sign Out')
  end

  it 'does not show username after log out' do
    sign_up('test_user')
    sign_out
    expect(page).to_not have_content('test_user')
  end

end


feature "logging in" do

  before :each do
    sign_up('test_user')
    sign_out
    sign_in('test_user')
  end


  it 'shows username on the homepage after login' do
    expect(page).to have_content('test_user')
  end


end

