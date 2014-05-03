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

require 'spec_helper'

describe Comment do


end
