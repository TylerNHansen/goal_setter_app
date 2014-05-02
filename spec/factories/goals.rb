# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  private     :boolean          default(FALSE), not null
#  completed   :boolean          default(FALSE), not null
#  user_id     :integer
#  title       :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    private false
    completed false
    user nil
    title "MyString"
    description "MyText"
  end
end
