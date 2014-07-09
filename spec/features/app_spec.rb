require "spec_helper"

feature "Homepage" do
  scenario "unregistered user should see a register button" do
    visit '/'

    expect(page).to have_button("Register")
  end
end