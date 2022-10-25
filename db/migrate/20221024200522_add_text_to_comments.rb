class AddTextToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :text, :string, null: false
  end
end
