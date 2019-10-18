class CreateReviews < ActiveRecord::Migration[5.2]

    def change
        create_table :reviews do |t|
            t.integer :user_id
            t.integer :restaurant_id
            t.string :content
            t.integer :rating
        end
    end
end