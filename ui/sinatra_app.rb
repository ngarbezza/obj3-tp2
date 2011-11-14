require 'sinatra'
require File.expand_path('../../prelude', __FILE__)

set :environment => Environment.for_author("Nahuel")

get '/' do
  erb :home
end

get '/browser' do
  class_selected = nil
  instance_methods = []
  class_methods = []
  method_code = nil

  if params[:class]
    class_selected = eval(params[:class])
    instance_methods = class_selected.instance_methods.sort
    class_methods = class_selected.methods.sort
  
    method_code = settings.environment.get_method_code(
      params[:class], params[:method_kind], params[:method_name]
    ) if params[:method_kind] && params[:method_name]

#    if params[:instance_method]
#      method_code = settings.environment.get_method_code(
#        params[:class], :instance, params[:instance_method]
#      )
#    elsif params[:class_method]
#      method_code = settings.environment.get_method_code(
#        params[:class], :class, params[:class_method]
#      )
#    end
  end

  erb :browser, :locals => {
    :classes => settings.environment.all_system_classes,
    :class_selected => class_selected,
    :instance_methods => instance_methods,
    :class_methods => class_methods,
    :method_code => method_code
  }
end

get '/inspector' do
  erb :inspector, :locals => {
    :object => nil, :exception => nil, :expression => params[:expression]
  }
end

post '/inspector' do
  begin
    object = eval(params[:expression]) if params[:expression]
    erb :inspector, :locals => {
      :object => object, :exception => nil, :expression => params[:expression]
    }
  rescue Exception => exc
    erb :inspector, :locals => {
      :object => nil, :exception => exc, :expression => params[:expression]
    }
  end
end

get '/changes' do
  erb :changes, :locals => { :changes => settings.environment.all_changes }
end

get '/changes/new_class' do
  erb :new_class
end

get '/changes/new_method' do
  erb :new_method
end

get '/changes/new_module' do
  erb :new_module
end

get '/changes/include_module' do
  erb :include_module
end

post '/changes/new_class' do
  settings.environment.create_new_class(params[:name], params[:superclass])
  redirect '/changes'
end

post '/changes/new_method' do
  settings.environment.create_new_method( \
    params[:target],
    params[:kind],
    params[:name],
    params[:code]
  )
  redirect '/changes'
end

post '/changes/new_module' do
  settings.environment.create_new_module(params[:name])
  redirect '/changes'
end

post '/changes/include_module' do
  settings.environment.include_module(params[:target], params[:module_name])
  redirect '/changes'
end
