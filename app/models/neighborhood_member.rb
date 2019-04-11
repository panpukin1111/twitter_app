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

class NeighborhoodMember < ApplicationRecord
end
