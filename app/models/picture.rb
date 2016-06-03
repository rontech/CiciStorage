class Picture < ActiveRecord::Base
  def Picture.gen_key
    10.times.map { SecureRandom.random_number(10) }.join
  end
end
