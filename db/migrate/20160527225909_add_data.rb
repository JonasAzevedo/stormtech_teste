class AddData < ActiveRecord::Migration
    def self.up
        Author.create(:name => 'Deitel & Deitel')
        Author.create(:name => 'Martin Fowler')
        Author.create(:name => 'Elisabeth Freeman')
        
        @author = Author.find_by_name('Deitel & Deitel')
        if @author
            Book.create(:title => 'Java How to Program', :edition_year => '2007', :author_id => @author.id)
            Book.create(:title => 'Internet & World Wide Web: How to Program', :edition_year => '2007', :author_id => @author.id)
        end
        
        @author = Author.find_by_name('Martin Fowler')
        if @author
            Book.create(:title => 'Patterns of Enterprise Application Architecture', :edition_year => '2002', :author_id => @author.id)             
        end
        
        @author = Author.find_by_name('Elisabeth Freeman')
        if @author
            Book.create(:title => 'Head First Design Patterns', :edition_year => '2004', :author_id => @author.id)             
        end       
    end
    
    def self.down
        Book.delete_all
        Author.delete_all        
    end
end