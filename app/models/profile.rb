class Profile < ApplicationRecord
  belongs_to :user

  validates :bio,
    allow_blank: true,
    length: { minimum: 3, maximum: 280 }
  validates :homepage,
    allow_blank: true,
    format: { with: %r{\Ahttps?://[a-zA-Z0-9._]+(/.*)?\z} },
    length: { maximum: 280 }
  validates :location,
    allow_blank: true,
    length: { maximum: 140 }
end
