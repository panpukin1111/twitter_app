# == Schema Information
#
# Table name: groups
#
#  id          :bigint(8)        not null, primary key
#  name        :string(255)      not null
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :integer          default("draft"), not null
#

class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users
    accepts_nested_attributes_for :group_users

    extend Enumerize
    enumerize :status, in: {非公開: 0, 公開: 1}, scope: true
end
