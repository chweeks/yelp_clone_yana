require 'rails_helper'

feature 'reviewing' do

  let!(:restaurant){ create :restaurant }
  let(:user){ build :user }

  before do
    sign_up(user)
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link "Review #{restaurant.name}"
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'if restaurant is deleted reviews are also deleted' do
    visit '/restaurants'
    click_link "Review #{restaurant.name}"
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link "Delete #{restaurant.name}"
    expect(page).not_to have_content "so so"
    expect(current_path).to eq '/restaurants'
  end

  scenario 'users cannot review the same restaurant twice' do
    visit '/restaurants'
    click_link "Review #{restaurant.name}"
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link "Review #{restaurant.name}"
    fill_in "Thoughts", with: "Still so so"
    select '2', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content 'You have already reviewed this restaurant'
  end

end
