class Link < ActiveRecord::Base
  CHARS = ("A".."Z").to_a + (('a'..'z').to_a + ('0'..'9').to_a) - %w(I 0 O 1 l)
  MIN_LENGTH = 6
  ROOT_URL = Rails.application
                  .routes.url_helpers
                  .url_for(action: 'new', controller: 'links', only_path: false, protocol: 'http')

  validates :original_url, format: { with: URI::regexp }

  def full_short_url
    ROOT_URL + self.short_url
  end

  def self.create_ensuring_uniqueness(original_url)
    link = self.find_or_initialize_by(original_url: original_url)
    if link.new_record?
      length = MIN_LENGTH
      loop do
        link.generate_short_url(length)
        begin
          link.save!
          break
        rescue ActiveRecord::RecordNotUnique => e
          length += 1
        end
      end
    end
    link
  end

  def generate_short_url(length)
    self.short_url = length.times.map { |a| CHARS.sample }.join
  end
end
