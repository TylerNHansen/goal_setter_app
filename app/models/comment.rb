# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :text             not null
#  user_id          :integer          not null
#  commentable_id   :integer          not null
#  commentable_type :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base
  validates :body, :user_id, :commentable_id, :commentable_type, presence: true
  validates :commentable_type, inclusion: { in: %w(User Goal) }
  belongs_to :commentable, polymorphic: true
  belongs_to :user

end
