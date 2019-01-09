require("pry")
require_relative("../db/sql_runner")
require_relative("./albums")
require_relative("./artists")
#
# album1 = Album.new({'title' => 'The White Album', ,
#   })

artist1 = Artist.new({'name' => 'The Beatles'})

artist1.save()

album1 = Album.new({'title' => 'The White Album', 'genre' => '60s',
  'artist_id' => artist1.id})

album2 = Album.new({'title' => 'The Black Album', 'genre' => '60s',
  'artist_id' => artist1.id})

album1.save()
album2.save()

Artist.all()
Album.all()

album1.title = 'Love me do'
album1.update() 

binding.pry
nil
