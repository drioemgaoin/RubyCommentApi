class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.text      :content
      t.datetime  :created_at

      t.timestamps
    end
  end
end
