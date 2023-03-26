class Group < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description

  before_create :slugify
  
  private
  def slugify
    self.slug = name.parameterize
  end
end
