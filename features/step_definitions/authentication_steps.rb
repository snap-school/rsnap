Given(/^a user is not authenticated$/) do
  visit '/auth/sign_out'
end

Given(/^a user visits the signin page$/) do
  #visit '/users/sign_in'
  visit root_path
end

When(/^he submits invalid signin information$/) do
  find("#user-menu").click
  within "#login-menu" do
    find("input[type=submit]").click
  end
end

Then(/^he should see an error message$/) do
  expect(page).to have_selector('div.alert.alert-danger')
end

Given(/^the user has an account$/) do
  @user = FactoryGirl.create(:user)
end

When(/^the user submits valid signin information$/) do
  find("#user-menu").click
  within "#login-menu" do
    fill_in "user_email",    with: @user.email
    fill_in "user_password", with: @user.password
    find("input[type=submit]").click
  end
end

Then(/^he should see her profile page$/) do
  expect(page).to have_text(@user.name)
end

Then(/^he should see a signout link$/) do
  find("#user-menu").click
  expect(page).to have_link("sign_out")
end

def authenticate_user(user=:user)
  visit root_path

  @user = FactoryGirl.create(user)

  find("#user-menu").click
  within "#login-menu" do
    fill_in "user_email",    with: @user.email
    fill_in "user_password", with: @user.password
    sleep 5 if @presentation
    find("input[type=submit]").click
  end
end

Given(/^a new user is authenticated$/) do
  authenticate_user
end

Given(/^a user is authenticated$/) do
  authenticate_user
end

Given(/^a professor is authenticated$/) do
  authenticate_user(:admin)
end
