class Cloth < ApplicationRecord
    validates :name,length: { minimum: 2 ,message: "Please Enter Name Correctly!!!"}
    validates :category,inclusion: { in: %w(Sports Casual Traditional),message: "%{value} is not a valid category" }
    validates :size,inclusion: { in: %w(S M L XL),message: "%{value} is not a valid size" }
    validates :color,length: { maximum: 3 ,message: "Please Enter color Correctly!!!"}
end
