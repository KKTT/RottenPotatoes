class Movie < ActiveRecord::Base
	def self.ratings
		self.select(:rating).map {|obj| obj.rating}.uniq
	end

end
