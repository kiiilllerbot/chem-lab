# frozen_string_literal: true

task save_elements_to_redis: :environment do
  elements = Element.all
  r = $redis.keys("element_*")
  $redis.del(r)
    
  elements.each do |e|
    if e.name.present?
      $redis.set("element_#{e.name}", [e.name, e.symbol, e.atomic_number, e.atomic_mass, e.description])
    end
  end
end