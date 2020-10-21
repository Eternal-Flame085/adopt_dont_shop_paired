class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  def pet_count
    pets.count
  end

  def average_rating
    review_total = 0
    if reviews.count > 0
      reviews.each do |review|
        review_total += review.rating
      end
      review_total/reviews.count
    end
  end

  def applications_count
    applications = []
    pets.each do |pet|
      applications << pet.applications
    end
    applications.flatten.uniq.count
  end
end
