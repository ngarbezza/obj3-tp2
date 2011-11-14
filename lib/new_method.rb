class NewMethod < ActiveRecord::Base

  ### Attributes: target, kind, name, code ###

  has_one :change, :as => :changeable

  validates_presence_of [:target, :kind, :name, :code]
  
  def execute
    get_target.class_eval(code) if is_instance_method?
    get_target.instance_eval(code) if is_class_method?
  end

  def undo
    if is_instance_method?
      get_target.instance_eval { remove_method name }
    elsif is_class_method?
      get_target.singleton_class.instance_eval { remove_method name }
    end
  end

  def to_s; "#{kind} method called #{name} defined in #{target}"; end

  private
  
  def get_target
    Object.const_get(target)
  end
  
  def is_instance_method?
    kind == "instance"
  end

  def is_class_method?
    kind == "class"
  end

end
