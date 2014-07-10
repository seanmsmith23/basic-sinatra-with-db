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

  scenario "logout button ends session" do
    clean_table
    register_user("Frankie")
    sign_in_user("Frankie")
    logout_user

    expect(page).to have_button("Register")
  end

end

feature "Registering" do
  scenario "user can register and see confirmation" do
    register_user("Frankie")

    expect(page).to have_content("Thank you for registering")
  end
end

feature "Error Messages" do
  scenario "user signs in with blank username or password" do
    visit '/'

    fill_in "username", :with =>""
    fill_in "password", :with =>"123"
    click_button "Sign In"

    expect(page).to have_content "No username provided"

    fill_in "username", :with =>"hello"
    fill_in "password", :with =>""
    click_button "Sign In"

    expect(page).to have_content "No password provided"

    fill_in "username", :with =>""
    fill_in "password", :with =>""
    click_button "Sign In"

    expect(page).to have_content "No username or password provided"
  end

  scenario "user registers with blank username or password" do
    visit '/registration'

    fill_in "username", :with =>""
    fill_in "password", :with =>"123"
    click_button "Submit"

    expect(page).to have_content "No username provided"

    fill_in "username", :with =>"hello"
    fill_in "password", :with =>""
    click_button "Submit"

    expect(page).to have_content "No password provided"

    fill_in "username", :with =>""
    fill_in "password", :with =>""
    click_button "Submit"

    expect(page).to have_content "No username or password provided"
  end

  scenario "user registers with existing username" do
    visit '/registration'

    fill_in "username", :with =>"FrankieRulz"
    fill_in "password", :with =>"123"
    click_button "Submit"

    visit '/registration'

    fill_in "username", :with =>"FrankieRulz"
    fill_in "password", :with =>"123"
    click_button "Submit"

    expect(page).to have_content "This user already exists"
  end
end

