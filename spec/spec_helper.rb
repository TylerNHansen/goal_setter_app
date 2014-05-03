# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def sign_up(username)
  visit new_user_url
  fill_in 'username', with: username
  fill_in 'password', with: 'test_pass'
  click_on 'Create User'
end

def sign_in(username, password = 'test_pass')
  visit new_session_url
  fill_in 'username', with: username
  fill_in 'password', with: password
  click_button 'Sign In'
end

def sign_out
  click_button 'Sign Out'
end

def visit_new_goal
  u = User.create(username: 'author', password: 'password')
  sign_in('author', 'password')
  visit new_user_goal_url(u)
end

def create_new_goal(
  title = 'Make a million dollars',
  descr = 'Step 1. Hire a coder. Step 2. Feed coder. Step 3. Profit')
  visit_new_goal
  fill_in 'Title', with: title
  fill_in 'Description', with: descr
  click_button 'Create New Goal'
  current_path
end

def create_new_comment_on(word)
  case word
  when 'goal'
    create_new_goal
  when 'user'
    sign_up('test_user')
  end
  fill_in 'Comment', with: 'test comment please ignore'
  click_button 'Add Comment'
  current_path
end

def comment_with_other_user(word)
  user1 = User.create(username: 'user1', password: 'password')
  user2 = User.create(username: 'user2', password: 'password')
  case word
  when 'user'
    comment_path = user_url(user1)
  when 'goal'
    goal = Goal.create(user_id: user1.id, title: 'User 1 Goal')
    comment_path = user_goal_url(user1, goal)
  end
  sign_in('user2', 'password')
  visit comment_path
  fill_in 'Comment', with: 'test comment please ignore'
  click_button 'Add Comment'
  sign_out
  sign_in('user1', 'password')
  visit comment_path
end










