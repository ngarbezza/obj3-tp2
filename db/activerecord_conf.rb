# Para loggear en la consola
# ActiveRecord::Base.logger = Logger.new(STDERR)

ActiveRecord::Base.establish_connection \
  :adapter  => 'sqlite3',
  :database => 'db/db.sqlite3'
