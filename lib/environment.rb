class Environment

  ### instance creation ###

  def self.for_author(author_name)
    self.new author_name
  end
  
  ### initializers ###
  
  def initialize(author_name)
    @author = Author.find_or_create_by_name author_name
    Change.all.each do |change|
      change.changeable.execute
    end
  end

  ### adding changes ###

  def add_change(changeable)
    changeable.save
    Change.create \
      :changeable => changeable, :timestamp => Time.now, :author => @author
    changeable.execute
  end
  
  def create_new_class(name, superclass)
    add_change(NewClass.new( \
      :name => name, :superclass => superclass.empty? ? :Object : superclass))
  end
  
  def create_new_method(target, kind, name, code)
    add_change(NewMethod.new( \
      :target => target, :kind => kind, :name => name, :code => code))
  end

  def create_new_module(name)
    add_change NewModule.new(:name => name)
  end

  def include_module(target, module_name)
    add_change(IncludeModule.new( \
      :target => target, :module_name => module_name))
  end

  ### undoing changes ###

  def undo_last_change
    change = Change.first
    change.undo
    change.destroy
  end

  ### accessing ###

  def all_changes
    Change.all
  end

  def all_system_classes
    cs = ObjectSpace.each_object(Module).entries
    cs.delete_if { |c| c.name.nil? }
    cs.sort_by! { |x| x.name }
    cs
  end

  def get_method_code(class_name, kind, method_name)
    ms = NewMethod \
      .where(:target => class_name) \
      .where(:kind => kind) \
      .where(:name => method_name)
    ms.empty? ? nil : ms.first.code
  end
  
end
