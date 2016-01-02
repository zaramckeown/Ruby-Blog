class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles

  default_scope lambda { order('categories.name') }

   def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
   end
end
