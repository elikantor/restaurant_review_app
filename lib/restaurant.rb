class Restaurant < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews

    def self.average_rating  
        count = 0
        agg_rating = 0 
        Review.all.each do |review|
            if review.restaurant == self
                count += 1
                agg_rating += self.rating 
            end
        end
        agg_rating / count
    end

end