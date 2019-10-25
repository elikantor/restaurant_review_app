require_all 'lib'

def add_a_bunch_of_lines_to_clear_CL
    50.times {print "\n"}
end

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
    prompt = TTY::Prompt.new
    add_a_bunch_of_lines_to_clear_CL
    new_arr = []
    user_input = prompt.enum_select ("Select a restaurant to view reviews.") do |menu|
        Restaurant.all.each do |restaurant|
            rest_arr = []
            average_rating = 0.0
            count = 0
            restaurant_id = restaurant.id
            rest_arr << "Restaurant: " + restaurant.name
            rest_arr << "Neighborhood: " + restaurant.location
            Review.all.each do |review|
                if review.restaurant_id == restaurant.id
                    average_rating += review.rating
                    count += 1
                end
            end
            rest_arr << "Average Rating: " + (average_rating / count).to_s
            rest_arr << "Number of Reviews: " + count.to_s
            new_arr << rest_arr.join("  -  ")
            #menu.choice = rest_arr.join("  -  ")
        end
        new_arr.each do |i|
            menu.choice i
        end
        menu.choice "Go Back"
    end

    counter = 0
    while counter < new_arr.length
        if user_input == new_arr[counter]
            res_id = 0
            review_string = ""
            Restaurant.all.each do |restaurant|
            if new_arr[counter].include? restaurant.name
                res_id = restaurant.id
                    Review.all.select do |review|
                        if review.restaurant_id == res_id
                            review_string = review_string + User.find(review.user_id).name + ": "
                            review_string += review.content
                            review_string += " Rating: #{review.rating} \n"
                        end
                    end
                end
            end
            puts review_string
            press_key_to_cont
        end
        counter += 1
    end

    print "\n"
    signed_in
end

def check_user_reviews
    string = ""
    Review.all.select do |review|
        if review.user_id == @user.id
           puts "Restaurant: " + Restaurant.find(review.restaurant_id).name + " - " + "Rating: " + review.rating.to_s + " - " + "Comment: " + review.content
        end
    end
    press_key_to_cont
    home_screen
end

def restaurant_rec_home
    add_a_bunch_of_lines_to_clear_CL
    Restaurant.all.select do |restaurant|
        rest_arr = []
        if restaurant.location == @user.home_location
            if average_rating(restaurant.name) >=4
                restaurant_id = restaurant.id
                rest_arr << "Restaurant: " + restaurant.name
                rest_arr << "Neighborhood: " + restaurant.location
                Review.all.each do |review|
                    if review.restaurant_id == restaurant.id
                        rest_arr << "Rating: " + review.rating.to_s
                        rest_arr << "Review: " + review.content + "\n"
                        # rest_arr << "Price: " + restaurant.($rating)
                        # if restaurant.price_rating == nil
                        #     rest_arr << "N/A"
                        # else restaurant.price_rating..times do 
                        #     rest_arr << "$"
                        #     end
                        # end
                    end
                end
                puts rest_arr.join("  -  ")
            end
        end
    end
    1.times { print "\n" }
end

def restaurant_rec_work_study
    add_a_bunch_of_lines_to_clear_CL
    Restaurant.all.select do |restaurant|
        rest_arr = []
        if restaurant.location == @user.work_study_location
            if average_rating(restaurant.name) >=4
                restaurant_id = restaurant.id
                rest_arr << "Restaurant: " + restaurant.name
                rest_arr << "Neighborhood: " + restaurant.location
                Review.all.each do |review|
                    if review.restaurant_id == restaurant.id
                        rest_arr << "Rating: " + review.rating.to_s
                        rest_arr << "Review: " + review.content
                    end
                end
                puts rest_arr.join("  -  ")
            end
        end
    end
    print "\n"
end

def restaurant_rec_food_genre
    add_a_bunch_of_lines_to_clear_CL
    Restaurant.all.select do |restaurant|
        rest_arr = []
        if restaurant.food_genre == @user.favorite_food_genre
            if average_rating(restaurant.name) >=4
                restaurant_id = restaurant.id
                rest_arr << "Restaurant: " + restaurant.name
                rest_arr << "Neighborhood: " + restaurant.location
                rest_arr << "Food Genre: " + restaurant.food_genre
                Review.all.each do |review|
                    if review.restaurant_id == restaurant.id
                        rest_arr << "Rating: " + review.rating.to_s
                        rest_arr << "Review: " + review.content
                    end
                end
                puts rest_arr.join("  -  ")
            end
        end
    end
    print "\n"
end

def write_review
    prompt = TTY::Prompt.new
    name_id = @user.id
    rest_id = 0
    puts "Please enter the name of a restaurant."
        res_name = gets.chomp
        Restaurant.all.select do |restaurant|
            if restaurant.name == res_name.titleize
                rest_id = Restaurant.find_by(name: restaurant.name).id 
            end
        end
        
        if !Restaurant.exists?(name: res_name)
            puts "This restaurant does not exist in our database."
            puts "What is the restaurant's food genre?"
            food_genre = gets.chomp
            puts "What is the location of this restaurant?"
            location = gets.chomp
            dollar_rating = prompt.select("How expensive is the restaurant? Enter a rating between 1-5 with 1 being the least expensive, 5 being the most expensive.", %w(1 2 3 4 5)).to_i
            Restaurant.create({name: res_name, food_genre: food_genre, location: location, :$rating => dollar_rating})
            rest_id = Restaurant.find_by(name: res_name).id
        end
        
        number_rating = prompt.select("Please enter your rating between 1-5", %w(1 2 3 4 5)).to_i
        puts "Please enter your review."
        review = gets.chomp
    Review.create({user_id: name_id, restaurant_id: rest_id, content: review, rating: number_rating })
    puts "Review Submitted!"
    press_key_to_cont
    signed_in
end

