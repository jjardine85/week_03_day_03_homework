require 'pry'
require_relative("../db/sql_runner")

class Album

  attr_accessor :id, :title, :genre, :artist_id

    def initialize(options)
      @id = options['id'].to_i if options ['id']
      @title = options['title']
      @genre = options['genre']
      @artist_id = options['artist_id']
    end

    def save
      sql = "INSERT INTO albums
      (title, genre, artist_id)

      VALUES
      ($1, $2, $3)
      RETURNING id"
      values = [@title, @genre, @artist_id]
      result = SqlRunner.run(sql, values)
      @id = result[0]['id'].to_i
    end

    def self.delete_all()
      sql = "DELETE FROM albums"
      SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM albums"
      albums = SqlRunner.run(sql)
      return albums.map {|album| Album.new(album)}
    end

    def artists()
      sql = "SELECT * FROM artists
      WHERE id = $1"
      values = [@artist_id]
      results = SqlRunner.run(sql, values)
      return Artist.new(results[0])
    end

    def update()
    sql = "
    UPDATE albums SET (
      title,
      genre,
      artist_id
    ) =
    (
      $1,$2, $3
    )
    WHERE id = $4"
    values = [@title, @genre, @id, @artist_id]
    SqlRunner.run(sql, values)
  end
end
