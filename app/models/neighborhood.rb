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

class Neighborhood < ApplicationRecord
end
