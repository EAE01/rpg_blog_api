class Page < ApplicationRecord
  belongs_to :post

  validates_uniqueness_of :number, scope: :post_id
end
