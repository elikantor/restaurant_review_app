class CommandLineInterface
    require 'pry'
    require_relative './methods.rb'
    require 'paint'

    def home_screen
        font = TTY::Font.new(:doom)
        pastel = Pastel.new
        add_a_bunch_of_lines_to_clear_CL
        puts pastel.red(font.write("Welcome  to"))
        puts pastel.red(font.write("Flatiron Yelp"))
        puts Paint["The restaurant review app.", :blue, :bold] 
        prompt = TTY::Prompt.new
        user_input = prompt.select () do |menu|
        menu.choice "Sign In"
        menu.choice "Sign Up"
        menu.choice "Exit"
    end    
        if user_input == "Sign In"
            choose_user
        elsif user_input == "Sign Up"
            sign_up
        elsif user_input == "Exit"
            puts "Goodbye"
        end
    end

    def choose_user
        prompt = TTY::Prompt.new
        user_input = prompt.select Paint[("Please select your username"), :blue, :bright] do |menu|
            User.all.each do |user|
                menu.choice "#{user.name}"
            end
        end
        User.find_by(name: user_input)
        @user = User.find_by(name: user_input)
        signed_in
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
        puts "User has been created!" 
        press_key_to_cont
        @user = User.find_by(name: name)
        signed_in
    end

    def signed_in
        prompt = TTY::Prompt.new
        user_input = prompt.select Paint[("Hello #{@user.name}. What would you like to do"), :blue, :bright] do |menu|
        menu.choice "Write a review"
        menu.choice "See restaurants that have been reviewed"
        menu.choice "Your recommended restaurants"
        menu.choice "Change User Info"
        menu.choice "Delete Account"
        menu.choice "Log out"
    end
        if user_input == "Write a review"
            write_review
        elsif user_input == "See restaurants that have been reviewed"
            restaurant_list
        elsif user_input == "Your recommended restaurants"
            recommendation_types
        elsif user_input == "Change User Info"
            change_user_info
        elsif user_input == "Delete Account"
            delete_account_check
        elsif user_input == "Log out"
            home_screen
        end
    end

    def delete_account_check
        prompt = TTY::Prompt.new
        user_input = prompt.select Paint[("Are you sure you want to delete your account?"), :blue, :bright] do |menu|
            menu.choice "Confirm"
            menu.choice "Go Back"
        end
            if user_input == "Confirm"
                Review.all.select do |review|
                    if review.user_id == @user.id
                        review.delete
                    end
                end
                @user.destroy
                puts "Your account has been deleted."
                press_key_to_cont
                home_screen
            elsif user_input == "Go Back"
                signed_in
            end
    end

    def change_user_info
        puts "Enter your name"
        new_name = gets.chomp
        puts "Enter your food genre"
        new_food_genre = gets.chomp
        puts "Enter the neighborhood you live in"
        new_neighborhood_home = gets.chomp
        puts "Enter the neighborhood you work in"
        new_neighborhood_work = gets.chomp
        user = User.find_by(name: @user.name)
        user.update(name: new_name, favorite_food_genre: new_food_genre, home_location: new_neighborhood_home, work_study_location: new_neighborhood_work)
        puts "User information updated!"
        press_key_to_cont
        signed_in
    end

    def recommendation_types
        prompt = TTY::Prompt.new
        user_input = prompt.select Paint[("What would you like to do"), :red] do |menu|
            menu.choice "Get restaurant recommendations for where you live"
            menu.choice "Get restaurant recommendations for where you work/study"
            menu.choice "Get restaurant recommendations for your favorite food genre"
            menu.choice "Go back"
        end

        if user_input == "Get restaurant recommendations for where you live"
            restaurant_rec_home
            press_key_to_cont
            signed_in 
        elsif user_input == "Get restaurant recommendations for where you work/study"
            restaurant_rec_work_study
            press_key_to_cont
            signed_in 
        elsif user_input == "Get restaurant recommendations for your favorite food genre"
            restaurant_rec_food_genre
            press_key_to_cont
            signed_in 
        elsif user_input == "Go back"
            signed_in
        end
    end

    def press_key_to_cont
        prompt = TTY::Prompt.new
        prompt.keypress("Press any key to continue.")
    end

end
