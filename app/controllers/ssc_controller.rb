class SscController < ApplicationController
    def index
        if !File.exists?("public/orderBooks.txt")
            flash[:error] = "Configuration file not found!"
        else
            arq = File.open("public/orderBooks.txt", "r")
            @fieldOrder = arq.readline.strip
            @modeAscDesc = arq.readline.strip
            arq.close

            if validarOrders(@fieldOrder, @modeAscDesc)
              @books = Book.joins(:author).order(@fieldOrder + ' ' + @modeAscDesc).all
            end
        end
    end

    def validarOrders(field, mode)        
        fieldOrders = ["id", "title", "edition_year", "authors.name"]
        modeAscDescs = ["asc", "desc"]

        if fieldOrders.include?(field) && modeAscDescs.include?(mode)
            return true
        else
            flash[:error] = "Check the field and mode in the configuration file!"
            return false
        end
    end
end