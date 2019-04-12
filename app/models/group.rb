# == Schema Information
#
# Table name: groups
#
#  id          :bigint(8)        not null, primary key
#  name        :string(255)      not null
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :integer
#

class Group < ApplicationRecord
    has_many :users, through: :group_users
    has_many :group_users
    accepts_nested_attributes_for :group_users
end
