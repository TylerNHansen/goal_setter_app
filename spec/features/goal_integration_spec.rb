require 'spec_helper'



feature 'making a goal' do

  it 'has a new goal page' do
    visit_new_goal
    expect(page).to have_content 'New Goal'
  end

  it 'creates a goal' do
    create_new_goal(
    'Make a million dollars',
    'hire a coder to make a facebook clone')
    expect(page).to have_content 'Make a million dollars'
    expect(page).to have_content 'hire a coder to make a facebook clone'
    expect(page).to have_content 'Not Complete'
  end

end

feature 'can edit goals' do

  before :each do
    create_new_goal
    click_link 'Edit'
  end

  it 'has an edit page' do
    expect(page).to have_content 'Edit Goal'
  end

  it 'edit page should be filled in' do
    expect(page).to have_content "Make a million dollars"
  end

  it 'should change content' do
    fill_in 'Title', with: 'Build a business'
    click_button 'Update Goal'
    expect(page).to have_content 'Build a business'
  end

end

feature 'can delete a goal' do

  before :each do
    create_new_goal
  end

  # create new goal redirects to goal show pages

  it 'goal show page has delete button' do
    expect(page).to have_button('Delete Goal')
  end

  it 'delete goal button removes goal and redirects to index' do
    click_button 'Delete Goal'
    expect(page).to_not have_content 'Make a million dollars'
  end

end
