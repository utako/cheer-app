require 'spec_helper'

feature 'Comment' do

  context 'User show page' do
    before :each do
      sign_up_as_hal_jordan
    end

    scenario 'should have an Add Comment form' do
      expect(page).to have_button 'Add Comment'
    end

    scenario 'should successfully create and show new comment with username' do
      comment_on_hals_page
      expect(page).to have_content "it ain't easy bein' green"
      expect(page).to have_content 'Author: hal_jordan'
    end

    scenario 'should not allow empty comments' do
      click_button 'Add Comment'
      expect(page).to have_content "Comment can't be blank"
    end

    scenario 'should have remove button' do
      comment_on_hals_page
      expect(page).to have_content "Remove Comment"
    end

    scenario 'should successfully remove comment' do
      comment_on_hals_page
      click_button 'Remove Comment'
      expect(page).not_to have_content "it ain't easy bein' green"
    end

  end


  context 'Goal show page' do
    before :each do
      sign_up_as_hal_jordan
      add_public_goal
      click_button 'Log Out'
      sign_up_as_batman
      click_link "Save the world"
    end

    scenario 'should have an Add Comment form' do
      expect(page).to have_button 'Add Comment'
    end

    scenario 'should successfully create and show new comment with username' do
      comment_on_hals_goal
      expect(page).to have_content "WTG"
      expect(page).to have_content 'Author: batman'
    end

    scenario 'should not allow empty comments' do
      click_button 'Add Comment'
      expect(page).to have_content "Comment can't be blank"
    end

    scenario 'should have remove button' do
      comment_on_hals_goal
      expect(page).to have_content "Remove Comment"
    end

    scenario 'should successfully remove comment' do
      comment_on_hals_goal
      click_button 'Remove Comment'
      expect(page).not_to have_content "WTG"
    end


  end
end