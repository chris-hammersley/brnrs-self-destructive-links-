require "rails_helper"
require "support/link_helper"

describe Link do
  include LinkHelper
  
  it "requires a url to be valid" do
    link = generate_valid_link
    expect(link).to be_valid

    link.url = nil
    expect(link).to_not be_valid
  end

  it "has a redirect_limit_flag which defaults to false" do
    link = generate_valid_link
    
    expect(link.redirect_limit_flag).to be false
  end

  it "has a redirect_limit which initializes to 0" do
    link = generate_valid_link

    expect(link.redirect_limit).to eq(0)
  end

  it "has a redirect_count which initializes at 0" do
    link = generate_valid_link

    expect(link.redirect_count).to eq(0)
  end

  it "has an expiration_time which defaults to 1 year from the time of creation" do
    time = Time.now
    link = generate_valid_link

    expect(link.expiration_time.to_i).to eq(time.next_year.round(0).to_i)
  end


  it "assigns an 8 digit random string to url_hash on creation" do
    link1  = generate_valid_link
    link2  = generate_valid_link
    
    expect(link1.url_hash).to_not eq(nil)
    expect(link1.url_hash.length).to eq(8)
    expect(link1.url_hash).to_not eq(link2.url_hash)
  end

end

describe "#is_active?" do
  include LinkHelper
  it "returns true when link is active" do
    link = generate_valid_link 
    link.redirect_count = 0
    link.redirect_limit = 1
    
    expect(link.is_active?).to be true
  end

  it "returns false when redirect_count reaches redirect_limit" do
    link = generate_redirect_expired_link

    expect(link.is_active?).to be false
  end

  it "returns false when expiration_time has passed" do
    link = generate_time_expired_link

    expect(link.is_active?).to be false
  end
end