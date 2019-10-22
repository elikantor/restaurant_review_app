require_all 'lib'

def average_rating(res_name)
    id_of_res = 0
    rating = 0
    count = 0
    Restaurant.all.select do |restaurant|
        if restaurant.name == res_name
           id_of_res = restaurant.id
        end
    end
    Review.all.each do |review|
        if id_of_res == review.restaurant_id 
            rating += review.rating
            count += 1
        end
    end
    rating = rating / count
end

def restaurant_list
    5.times {print "\n"}
    Restaurant.all.each do |restaurant|
        rest_arr = []
        restaurant_id = restaurant.id
        rest_arr << "Restaurant: " + restaurant.name
        rest_arr << "Neighborhood: " + restaurant.location
        Review.all.each do |review|
            if review.restaurant_id == restaurant.id
                rest_arr << "Rating: " + review.rating.to_s
            end
        end
        puts rest_arr.join("  -  ")
    end
    print "\n"
    signed_in
end

def restaurant_rec_home
    6.times { print "\n" }
    Restaurant.all.select do |restaurant|
        if restaurant.location == @user.home_location
            if average_rating(restaurant.name) >=4
                puts restaurant.name
            end
        end
    end
    1.times { print "\n" }
    signed_in
end

def restaurant_rec_work_study
    6.times { print "\n"}
    Restaurant.all.select do |restaurant|
        if restaurant.location == @user.work_study_location
            if average_rating(restaurant.name) >=4
                puts restaurant.name
            end
        end
    end
    print "\n"
    signed_in
end

def restaurant_rec_food_genre
    6.times { print "\n"}
    Restaurant.all.select do |restaurant|
        if restaurant.food_genre == @user.favorite_food_genre
            if average_rating(restaurant.name) >=4
                puts restaurant.name
            end
        end
    end
    print "\n"
    signed_in 
end

def write_review
    name_id = @user.id
    rest_id = 0
    puts "Please enter the name of a restaurant."
        res_name = gets.chomp.capitalize
        Restaurant.all.select do |restaurant|
            if restaurant.name == res_name
                rest_id = Restaurant.find_by(name: restaurant.name).id 
            end
        end
        
        if !Restaurant.exists?(name: res_name)
            puts "This restaurant does not exist in our database."
            puts "What is the restaurant's food genre?"
            food_genre = gets.chomp
            puts "What is the location of this restaurant?"
            location = gets.chomp
            puts "What is the average price rating of this restaurant"
            dollar_rating = gets.chomp
            Restaurant.create({name: res_name, food_genre: food_genre, location: location, :$rating => dollar_rating})
            rest_id = Restaurant.find_by(name: res_name).id
        end
    
        puts "Please enter your review."
            review = gets.chomp
        puts "Please enter your rating between 1-5."
        # while rating != 1...5
            number_rating = gets.chomp
        #     if rating = 1...5
        #         rating = number_rating
        #     else puts "Please enter your rating between 1-5."
        #     end
        # end
    Review.create({user_id: name_id, restaurant_id: rest_id, content: review, rating: number_rating })
    signed_in
end

