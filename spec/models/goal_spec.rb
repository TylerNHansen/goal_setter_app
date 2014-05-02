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

require 'spec_helper'

describe Goal do


end
