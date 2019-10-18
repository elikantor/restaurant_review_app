class CreateRestaurants < ActiveRecord::Migration[5.2]

    def change
        create_table :restaurants do |t|
            t.string :name
            t.string :food_genre
            t.string :location
            t.integer :$rating
        end
    end
end