def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between 3 and 5
  # (inclusive). Show the id, title, year, and score.
  Movie
    .select(:id, :title, :yr, :score)
    .where(yr: 1980..1989)
    .where(score: 3..5)

end

def bad_years
  # List the years in which no movie with a rating above 8 was released.
  good_years = Movie.select(:yr).where("score > 8")

  Movie
    .where.not("yr IN (?)", good_years)
    .group(:yr)
    .pluck(:yr)

end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor
    .select(:id, :name)
    .joins(:movies)
    .where(movies: {title: title})
    .order("ord ASC")

end

def vanity_projects
  # List the title of all movies in which the director also appeared as the
  # starring actor. Show the movie id, title, and director's name.

  # Note: Directors appear in the 'actors' table.

  Movie
    .select(:id, :title, :name)
    .joins(:actors)
    .where('movies.director_id = actors.id AND ord = 1')
  
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name, and number of supporting roles.
  Actor
    .select("actors.id, actors.name, COUNT(ord) AS roles")
    .joins(:castings)
    .group("actors.id")
    .where("ord > 1" )
    .order("COUNT(ord) DESC")
    .limit(2)

  
end