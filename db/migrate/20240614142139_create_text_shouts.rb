class CreateTextShouts < ActiveRecord::Migration[7.1]
  def change
    create_table :text_shouts do |t|
      t.string :body, null: false

      t.timestamps
    end
  end
end
