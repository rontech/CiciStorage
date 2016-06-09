class Picture < ActiveRecord::Base
  after_initialize :set_default, if: :new_record?
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
   mount_uploader :temp_file, ::ImageUploader
  validates :user_id, presence: true
  validates :file_name, presence: true, length: { maximum: 100 }
  validates :content_type, presence: true, length: { maximum: 50 }
  validate :temp_file_size

  def set_attributes
    if temp_file.present?
      self.content_type = temp_file.file.content_type
      self.file_name = File.basename(temp_file.to_s)
    end
  end

  private

    def Picture.gen_key
      20.times.map { SecureRandom.random_number(10) }.join
    end

    def set_default
      self.url_key ||= Picture.gen_key
    end

    def temp_file_size
      if temp_file.size > 5.megabytes
        errors.add(:temp_file, "should be less than 5MB")
      end
    end

end
