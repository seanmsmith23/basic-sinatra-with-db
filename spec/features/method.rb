
def register_user(name)
  visit '/registration'

  fill_in "username", :with => "#{name}"
  fill_in "password", :with => "secretpassword"

  click_button "Submit"

  expect(page).to have_content("Thank you for registering")
end

def sign_in_user(name)
  visit '/'

  fill_in "username", :with => "#{name}"
  fill_in "password", :with => "secretpassword"

  click_button "Sign In"
end

def logout_user
  visit '/logout'

end

# def clean_table
#   @database_connection.sql("DELETE FROM users WHERE id > 0")
# end
