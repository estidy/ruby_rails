class AddIndexToProducts < ActiveRecord::Migration[7.0]
  def change
    add_index :products, [:title,:description], type: :fulltext
  end
end
