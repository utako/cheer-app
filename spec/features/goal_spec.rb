require 'spec_helper'

feature 'Goal' do
  before :each do
    sign_up_as_hal_jordan
  end

  it 'Sign up navigates to root page' do
    expect(page).to have_content 'Goals'
  end

  context 'Adding a goal' do

    it 'Body cannot be blank' do
      visit '/goals/new'
      click_button 'Add Goal'
      expect(page).to have_content "Body can't be blank"
    end

    scenario 'must be logged in to add a goal' do
      click_button 'Log Out'
      visit '/goals'
      expect(page).to have_content 'Sign Up'
      expect(page).to have_content 'Password'
    end

    it 'should have an Add Goal link' do
      expect(page).to have_content 'Add Goal'
    end

    scenario 'should successfully add goal and redirects to show page' do
      add_public_goal
      expect(page).to have_content 'Save the world'
    end

    scenario 'should default to public' do
      add_public_goal
      expect(Goal.first.private).to be(false)
    end

    scenario 'and choosing private should be private' do
      add_private_goal
      expect(Goal.first.private).to be(true)
    end

  end

  context 'Editing a goal' do
    before :each do
      add_public_goal
    end

    it 'should have an Edit Goal link' do
      expect(page).to have_content 'Edit Goal'
    end

    scenario 'should successfully edit goal and redirect to show page' do
      edit_goal
      expect(page).to have_content 'Find magical ring'
    end

    scenario 'only user should be allowed to edit goal' do
      click_button 'Log Out'
      sign_up_as_batman
      page.should_not have_content "Edit Goal"
    end

    scenario 'edit goal page should prefill content' do
      click_link 'Edit Goal'
      find_by_id("goal").value.should eq 'Save the world'
    end

    scenario 'should have remove goal button' do
      click_link 'Edit Goal'
      page.should have_button 'Remove Goal'
    end

    scenario 'Removing a goal' do
      click_link 'Edit Goal'
      click_button 'Remove Goal'
      page.should have_content 'Goals'
      page.should have_content 'Add Goal'
    end

  end

  context 'Completing a goal' do
    before :each do
      add_public_goal
    end

    scenario "it should have a 'completed' button" do
      visit goals_url
      expect(find('input[type="checkbox"]')).not_to be_checked

    end

    scenario "once goal is completed, 'completed' button no longer shows up" do
      visit goals_url
      check('completed')
      click_button 'update'
      visit goals_url
      page.should have_content 'Completed'
    end

  end

end