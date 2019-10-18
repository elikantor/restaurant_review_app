class CreateUsers < ActiveRecord::Migration[5.2]

    def change
        create_table :users do |t|
            t.string :name
            t.string :favorite_food_genre
            t.string :home_location
            t.string :work_study_location
        end
    end
end