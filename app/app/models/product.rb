class Product < ApplicationRecord

    include PgSearch::Model
    
    pg_search_scope :search_full_text, against: {
        title: 'A',
        description: 'B'
    }, using: { tsearch: { prefix: true } }

    has_one_attached :photo

    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true

    belongs_to :category
end
