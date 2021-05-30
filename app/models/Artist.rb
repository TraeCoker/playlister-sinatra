class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :songs
    
    def self.titleize 
        all.each do |artist| 
            artist.update(name: artist.name.titleize)
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