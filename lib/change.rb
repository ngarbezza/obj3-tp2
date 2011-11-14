class Change < ActiveRecord::Base

  ### Attributes: changeable, author, timestamp ###

  belongs_to :changeable, :polymorphic => true, :dependent => :destroy

  belongs_to :author

  default_scope :order => 'timestamp ASC'

  validates_presence_of [:changeable, :author]

  def to_s; "#{changeable.to_s} - by #{author.to_s} at #{timestamp}"; end

end
