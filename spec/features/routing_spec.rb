require "rails_helper"

feature "Smoke Test" do
  scenario "Homepage" do
    visit root_path

    expect(page).to have_http_status(200)
  end

  scenario "Valid link" do
    link = create(:link)

    visit "/#{link.url_string}"

    expect(page.current_url).to eq(link.target_url)
  end

  scenario "Invalid link" do
    link = create(:time_expired_link)

    visit "/#{link.url_string}"

    expect(page.current_path).to eq("/#{link.url_string}")
    expect(page).to have_css 'h1', text: 'Missing'
  end

  scenario "Nonexistant link" do
    path = "/nonsense"
    visit path

    expect(page.current_path).to eq(path)
    expect(page).to have_css 'h1', text: 'Missing'
  end

  scenario "Invalid path" do
    path =  "/badpath/badurl.html"
    visit path

    expect(page.current_path).to eq(path)
    expect(page).to have_css 'h1', text: 'Missing'
  end
end
