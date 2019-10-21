class CommandLineInterface
    require 'pry'

    def home_screen
        prompt = TTY::Prompt.new
        user_input = prompt.select ("Welcome to Flatiron Yelp, the restaurant review app") do |menu|
        menu.choice "Sign In"
        menu.choice "Sign Up"
        menu.choice "Exit"
        end
        
            if user_input == "Sign In"
                puts "signed in"
                signed_in
            elsif user_input == "Sign Up"
                puts "signed up"
                sign_up
            elsif user_input == "Exit"
                puts "Goodbye"
            end
    end

    def sign_up
        puts "Please enter your name."
            name = gets.chomp
        puts "Please enter your favorite food genre."
            genre = gets.chomp
        puts "Please enter what neighborhood you live in."
            home = gets.chomp
        puts "Please enter what neighborhood you work in/go to school." 
            work = gets.chomp
        User.create({name: name, favorite_food_genre: genre, home_location: home, work_study_location: work})
        signed_in
    end

    def signed_in
        prompt = TTY::Prompt.new
        new_user_input = prompt.select ("What would you like to do") do |menu|
        menu.choice "Write a review"
            write_review
        menu.choice "Get a restaurant recommendation for home"
        menu.choice "Get a restaurant recommendation for working/studying"
        menu.choice "Log out"
        end
        
            if new_user_input == "Write a review"
                write_review
            elsif new_user_input == "Get a restaurant recoomendation for home"
                sign_up
            elsif new_user_input == "Get a restaurant recoomendation for working/studying"
                sign_up
            elsif new_user_input == "Log out"
                home_screen
            end
    end

    def write_review
        name_id = 
        
        puts "Please enter the name of a restaurant."
            res_name = gets.chomp.capitalize
            Restaurant.all.select do |restaurant|
                if restaurant.name == res_name
                    rest_id = restaurant.id 
                else
                    puts "This restaurant does not exist in our database."
                    puts "What is the restaurants food genre?"
                    food_genre = gets.chomp
                    puts "What is the location of this restaurant?"
                    location = gets.chomp
                    puts "What is the average price rating of this restaurant"
                    dollar_rating = gets.chomp

                    Restaurant.create({name: res_name, food_genre: food_genre, location: location, :$rating => dollar_rating})
                    rest_id = Restaurant.where("name = res_name").id

                end
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
    end

end
