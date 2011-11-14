ActiveRecord::Schema.define do
  create_table :new_classes do |t|
    t.string :name
    t.string :superclass
  end

  create_table :new_modules do |t|
    t.string :name
  end

  create_table :include_modules do |t|
    t.string :target
    t.string :module_name
  end

  create_table :new_methods do |t|
    t.string :target
    t.string :kind
    t.string :name
    t.string :code
  end

  create_table :changes do |t|
    t.integer :changeable_id
    t.string :changeable_type
    t.integer :author_id
    t.datetime :timestamp
  end

  create_table :authors do |t|
    t.string :name
  end
end
