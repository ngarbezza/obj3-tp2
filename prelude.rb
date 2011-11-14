$:.unshift File.dirname(__FILE__)

# para ver sources de metodos
require 'ri_for'
# ORM
require 'active_record'
require 'logger'
# Configuracion
require 'db/activerecord_conf'
# Esquema de BBDD
# require 'db/activerecord_schema'
# clases del dominio
require 'lib/author'
require 'lib/change'
require 'lib/environment'
require 'lib/include_module'
require 'lib/new_class'
require 'lib/new_method'
require 'lib/new_module'
