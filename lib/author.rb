class Author < ActiveRecord::Base

  ### Attributes: name, changes

  has_many :changes

  def to_s; name; end

end
