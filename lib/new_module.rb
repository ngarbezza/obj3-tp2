class NewModule < ActiveRecord::Base

  ### Attributes: name ###

  has_one :change, :as => :changeable

  validates_presence_of :name

  def execute; Object.const_set name, Module.new; end

  def undo; Object.instance_eval { remove_const name }; end

  def to_s; "Module #{name} created"; end

end
