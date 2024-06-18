class CreateFollowingRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :following_relationships do |t|
      t.references :follower, index: true, foreign_key: { to_table: :users }, null: false
      t.references :followed_user, index: true, foreign_key: { to_table: :users }, null: false
      
      t.timestamps
    end
  end
end
