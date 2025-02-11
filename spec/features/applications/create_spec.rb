require 'rails_helper'

RSpec.describe 'adding a new application' do
  it 'creates a new application' do
    visit '/applications/new'

    fill_in("Name", with: "Jelly Boy")
    fill_in('Street Address', with: "234 Smart Guy Ln.")
    fill_in('City', with: "Tuscaloosa")
    fill_in('State', with: "ID")
    fill_in('Zip Code', with: "86753")

    click_button('Submit')

    id = Application.last.id

    expect(current_path).to eq("/applications/#{id}")

    expect(page).to have_content("Jelly Boy")
    expect(page).to have_content("234 Smart Guy Ln.")
    expect(page).to have_content("Tuscaloosa")
    expect(page).to have_content("ID")
    expect(page).to have_content("86753")
    # expect(page).to have_content("Because I am Jelly Boy!")
    expect(page).to have_content("In Progress")
  end

  describe 'Starting an application, form not completed' do
    it 'does not allow an incomplete application' do
      visit '/applications/new'

      fill_in("Name", with: "Jelly Boy")
      fill_in('City', with: "Tuscaloosa")
      fill_in('Zip Code', with: "86753")

      click_button('Submit')

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error")
      expect(page).to have_content("Street address can't be blank")
      expect(page).to have_content("State can't be blank")
    end

    it 'does not allow non-numeric zip codes' do
      visit '/applications/new'

      fill_in("Name", with: "Jelly Boy")
      fill_in('Street Address', with: "234 Smart Guy Ln.")
      fill_in('City', with: "Tuscaloosa")
      fill_in('State', with: "ID")
      fill_in('Zip Code', with: "ABCDE")

      click_button('Submit')

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error: Zip code is not a number")
    end
  end
end
