# == Schema Information
#
# Table name: neighborhoods
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class NeighborhoodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
