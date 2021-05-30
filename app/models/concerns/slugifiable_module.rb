module Slugifiable 

    def slug 
        name = self.name.downcase
        name.gsub! ' ', '-'
        name 
    end 

    def self.find_by_slug(slug)
        name = slug.gsub! '-', ' '
        self.find_by(name: name.titleize)
    end 

end 