# == Schema Information
#
# Table name: group_users
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  group_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class GroupUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
