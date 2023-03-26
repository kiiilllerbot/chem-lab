# frozen_string_literal: true

# One time task to save all existing groups to redis.
task save_groups_to_redis: :environment do
  groups = Group.all
  r = $redis.keys("group_*")
    $redis.del(r)
    
    groups.each do |g|
      if g.name.present?
        $redis.set("group_#{g.name}", g.name)
      end
    end
end