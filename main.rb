$:.unshift File.dirname(__FILE__)
require 'prelude'

### Main ###

env = Environment.for_author "Nahuel"
#env.add_change(NewClass.new :name => :Perro, :superclass => :Object)
#env.add_change(NewMethod.new :target => :Perro,
#  :kind => :instance,
#  :name => :ladrar, 
#  :code => <<-EOS)
#  def ladrar
#    'Guau!'
#  end
#EOS

# Ya puedo llamar a Perro y a ladrar
perro = Perro.new
#puts perro.ladrar
#env.add_change(NewMethod.new :target => :Perro,
#  :kind => :class,
#  :name => :nuevo,
#  :code => <<-EOS)
#  def nuevo
#    new
#  end
#EOS

# Ahora puedo llamar al metodo de clase >>nuevo
#perro2 = Perro.nuevo
#puts perro2.ladrar

# Para borrar DB despues de cada corrida
# puts `> db/db.sqlite3`
