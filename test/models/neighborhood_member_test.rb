# == Schema Information
#
# Table name: neighborhood_members
#
#  id              :bigint(8)        not null, primary key
#  neighborhood_id :integer
#  user_id         :integer
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class NeighborhoodMemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
