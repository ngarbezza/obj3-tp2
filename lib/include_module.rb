#
# A change that includes a module in a class or in another module.
#
class IncludeModule < ActiveRecord::Base

  ### Attributes: target, module_name ###

  has_one :change, :as => :changeable

  validates_presence_of [:target, :module_name]

  def execute
    get_target.class_eval "include #{Object.const_get(module_name)}"
  end

  def undo
    # TODO no hay forma de excluir un module facilmente,
    # solo se puede sacando a mano todos los metodos
    # problema: si hay alguno redefinido
  end

  def to_s; "Module #{module_name} included into #{target}"; end

  def get_target; Object.const_get target; end

end
