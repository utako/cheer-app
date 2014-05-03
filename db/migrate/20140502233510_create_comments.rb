class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.references :commentable, polymorphic: true
      t.integer :commenter_id, null: false

      t.timestamps
    end
    add_index :comments, :commenter_id
  end
end
