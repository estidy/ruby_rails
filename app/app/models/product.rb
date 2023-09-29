class Product < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true

    has_one_attached :photo    

    belongs_to :category

    include PgSearch::Model
    
    pg_search_scope :search_full_text, against: {
        title: 'A',
        description: 'B'
    }, using: { tsearch: { prefix: true } }

    ORDER_BY = {
        Recientes:  "created_at DESC",
        Mas_Caro:   "price DESC",
        Mas_Barato: "price ASC"
    }

end
