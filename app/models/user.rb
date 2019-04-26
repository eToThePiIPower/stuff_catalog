class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :profile, update_only: true

  validates :username,
    length: { minimum: 6, maximum: 32 },
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[a-zA-Z0-9._]+\z/,
              message: 'can only contain alphanumeric characters, underscores, or periods' }

  after_initialize do
    build_profile if new_record? && profile.blank?
  end

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable, :lockable, :timeoutable, :trackable
end
