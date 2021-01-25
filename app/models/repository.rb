class Repository < ApplicationRecord
  acts_as_nested_set

  validates :name, presence: true, uniqueness: { scope: :parent_id }
end
