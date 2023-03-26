class Element < ApplicationRecord
  belongs_to :group
  validates_presence_of :name
  validates_presence_of :atomic_number
  validates_presence_of :atomic_mass
  validates_presence_of :symbol
  validates_presence_of :description

  after_commit :set_to_redis_cache

  private
  def set_to_redis_cache
    $redis.set("element_#{self.name}", [self.name, self.symbol, self.atomic_number, self.atomic_mass, self.description])
  end
end
