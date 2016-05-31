json.array!(@books) do |book|
  json.extract! book, :id, :title, :edition_year, :author_id
  json.url book_url(book, format: :json)
end
