class Book < ActiveRecord::Base
    belongs_to :author
    
    validates_presence_of :title
    validates_presence_of :edition_year
    validates_presence_of :author_id       
end
