class Image < ApplicationRecord
  validates :number, :uniqueness => true
end
