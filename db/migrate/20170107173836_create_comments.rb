class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer   :user_id, index: true
      t.string    :username
      t.text      :content
      t.datetime  :created_at

      t.timestamps
    end
  end
end
