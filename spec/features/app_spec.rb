require "spec_helper"

feature "Homepage" do
  scenario "unregistered user should see a register button" do
    visit '/'

    expect(page).to have_button("Register")
  end

  scenario "unregistered user can click button and be directed to a  registration page" do
    visit '/'

    click_link "Register"

    expect(page).to have_content("Register Here!")
  end

end