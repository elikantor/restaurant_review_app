require_all 'lib'

def res_average_rating(res_name)
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

