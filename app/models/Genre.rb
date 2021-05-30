class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs 

    def self.titleize 
        all.each do |genre| 
            genre.update(name: genre.name.titleize)
        end 
    end 

    def self.normalize 
        downcased = []
        all.collect do |song|
            downcased << [song.name.downcase, song.id]
        end 
        downcased 
    end 
    
    def slug 
        name = self.name.downcase
        name.gsub! ' ', '-'
        name 
    end 

    def self.find_by_slug(slug)
       all_names = normalize
        slug = slug.gsub! '-', ' ' if slug.include?("-")
        
        slug_id = all_names.detect do |name_array|
            name_array[0] == slug 
        end.last
        self.find(slug_id)
    end 
end 