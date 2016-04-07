class Link < ActiveRecord::Base
  validates_presence_of :target_url
  after_initialize :generate_url_string, :set_default_expiration
  before_validation :add_url_protocol
    
  def is_active?
    return under_max_redirects? && not_expired?
  end

  private
    def generate_url_string
      self.url_string = SecureRandom.base64(6).tr('+/=', 'N3w')
    end

    def set_default_expiration
      self.expiration ||= Time.now.next_year.round(0)
    end

    def under_max_redirects?
      max_redirects == 0 ? true : self.redirects < self.max_redirects
    end

    def not_expired?
      Time.now < self.expiration
    end

    def add_url_protocol
      unless self.target_url[/\Ahttp:\/\//] || self.target_url[/\Ahttps:\/\//]
        self.target_url = "http://#{self.target_url}"
      end
    end
  
end
