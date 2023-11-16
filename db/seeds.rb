# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"

Bookmark.destroy_all
puts "Destroying bookmarks"

List.destroy_all
puts "Destroying lists"

Movie.destroy_all
puts "Destroying movies"

def get_movies(url)
  movies_serialised = URI.open(url).read
  movies = JSON.parse(movies_serialised)

  puts "Scraping api"

  movies["results"].each do |movie|
    title = movie["title"]
    overview = movie["overview"]
    rating = movie["vote_average"]
    poster_url = "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}"
    Movie.create(
      title: title,
      overview: overview,
      rating: rating,
      poster_url: poster_url
    )
    puts "Movie created!"
  end
end

get_movies("https://tmdb.lewagon.com/movie/top_rated")
get_movies("https://tmdb.lewagon.com/movie/popular")
