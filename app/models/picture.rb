class Picture < ActiveRecord::Base
  belongs_to :user
  def Picture.gen_key
    20.times.map { SecureRandom.random_number(10) }.join
  end
end
