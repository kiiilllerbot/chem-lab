class Group < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description

  before_create :slugify
  after_commit :set_to_redis_cache
  
  private
  def slugify
    self.slug = name.parameterize
  end

  def set_to_redis_cache
    $redis.set("group_#{self.name}", self.name)
  end
end
