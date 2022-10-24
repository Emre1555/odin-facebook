class AddLikableTypeToLike < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :likable_type, :string, null: false
    change_column_null :likes, :likable_id, false
  end
end
