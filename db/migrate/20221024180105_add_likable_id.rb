class AddLikableId < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :likable_id, :integer, null: false
  end
end
