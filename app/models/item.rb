class Item < ApplicationRecord
  belongs_to :user
  validates :title, presence: true

  scope :author, ->(author) { where(':author = ANY(authors)', author: author) }
  scope :category, ->(category) { where(':category = ANY(categories)', category: category) }
  scope :clike, lambda { |category|
    where("array_to_string(categories, '||') ILIKE :category", category: "%#{category}%")
  }

  def authors=(authors)
    case authors
    when String
      self[:authors] = authors.split(', ')
    when Array
      self[:authors] = authors
    end
  end

  def categories=(categories)
    case categories
    when String
      self[:categories] = categories.split(', ')
    when Array
      self[:categories] = categories
    end
  end
end
