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

feature "Registering" do
  scenario "user can register and see confirmation" do
    visit '/registration'

    fill_in "username", :with => "Frankie"
    fill_in "password", :with => "secretpassword"

    click_button "Submit"

    expect(page).to have_content("Thank you for registering")
  end
end