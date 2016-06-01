require 'json'

class SscController < ApplicationController

    def index
        flash[:error] = nil
        if !File.exists?("public/orderBooks.json")
            flash[:error] = "Not found file configuration 'public/orderBooks.json' !"
        else
            begin
                file = File.read("public/orderBooks.json")
                data = JSON.parse(file)
            rescue                
                flash[:error] = "An error ocurred while processing the file 'public/orderBooks.json' !"
                return false
            end

            @campos = ""
            data.each do |key, value|
                value.each do |k|
                    if validarKeys(k.keys) && validarValues(k["field"], k["mode"])
                        if @campos != ""
                            @campos << ", "
                        end
                        @campos << k["field"] + " " + k["mode"]
                    else
                        return false
                    end
                end
            end

            @books = Book.joins(:author).order(@campos).all
        end
    end


    def validarKeys(keys)
        if (keys[0] == "field") && (keys[1] == "mode")
            return true
        else
            flash[:error] = "Check the keys in the file 'public/orderBooks.json' !"
            return false
        end
    end


    def validarValues(field, mode)
        fields = ["id", "title", "edition_year", "authors.name"]
        modes = ["asc", "desc"]

        if fields.include?(field) && modes.include?(mode)
            return true
        else
            flash[:error] = "Check the field and mode in the file 'public/orderBooks.json' !"
            return false
        end
    end
end