require 'spec_helper'

feature "the signup process" do

  it "has a new user page" do
    visit '/users/new'
    page.should have_content "Sign Up"
  end

  feature "signing up a user" do
    it "shows username on the homepage after signup" do
      sign_up_as_hal_jordan
      page.should have_content "hal_jordan"
    end
  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
    log_in_as_hal_jordan
    page.should have_content 'hal_jordan'
  end

end

feature "logging out" do
  before :each do
    sign_up_as_hal_jordan
    click_button 'Log Out'
  end

  it "begins with logged out state" do
    page.should have_content 'Sign In'
    page.should have_content 'Username'
  end

  it "doesn't show username on the homepage after logout" do
    page.should_not have_content 'hal_jordan'
  end

end