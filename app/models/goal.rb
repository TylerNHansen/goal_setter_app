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

class Goal < ActiveRecord::Base
  include Commentable
  validates :title, :user, presence: true

  belongs_to :user

  def to_s
    self.title
  end

end
