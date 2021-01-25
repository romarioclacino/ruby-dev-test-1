class Repository < ApplicationRecord
  acts_as_nested_set

  has_many_attached :files

  validates :name, presence: true, uniqueness: { scope: :parent_id }

  scope :main, -> { where(parent_id: nil) }
end
