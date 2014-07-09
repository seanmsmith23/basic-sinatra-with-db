require "spec_helper"
require_relative "method"

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

  scenario "user can sign in and have a greeting presented to them" do
    register_user("Frankie")
    sign_in_user("Frankie")

    expect(page).to have_content("Welcome Frankie")
  end

  scenario "user should not see register button after logging in" do
    register_user("Frankie")
    sign_in_user("Frankie")

    expect(page).to_not have_button("Register")
    expect(page).to have_button("Logout")
  end

end

feature "Registering" do
  scenario "user can register and see confirmation" do
    register_user("Frankie")

    expect(page).to have_content("Thank you for registering")
  end
end

