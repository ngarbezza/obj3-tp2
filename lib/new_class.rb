class NewClass < ActiveRecord::Base

  ### Attributes: name, superclass ###

  has_one :change, :as => :changeable

  validates_presence_of [:name, :superclass]

  def execute
    Object.const_set(name, Class.new(Object.const_get(superclass)))
  end

  def undo
    Object.instance_eval { remove_const name }
  end

  def to_s; "Class #{name} created"; end

end
