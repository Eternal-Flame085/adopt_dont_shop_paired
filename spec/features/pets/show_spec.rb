require 'rails_helper'

describe 'As a visitor' do
  describe 'I see a single pet' do
    it 'should have a header' do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                         name: 'Max',
                         age: '3',
                         sex: 'male',
                         description: 'test',
                         status: 'Adoptable',
                         shelter_id: "#{shelter_1.id}")

      visit "/pets/#{pet_1.id}"
      expect(page).to have_content("Name: #{pet_1.name}")
    end

    it 'Should have a picture for the pet' do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                         name: 'Max',
                         age: '3',
                         sex: 'male',
                         description: 'test',
                         status: 'Adoptable',
                         shelter_id: "#{shelter_1.id}")

      visit "/pets/#{pet_1.id}"
      expect(page).to have_xpath("//img[contains(@src,'#{pet_1.image}')]")
    end

    it 'should have the pets info' do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                         name: 'Max',
                         age: '3',
                         sex: 'male',
                         description: 'test',
                         status: 'Adoptable',
                         shelter_id: "#{shelter_1.id}")

      visit "/pets/#{pet_1.id}"
      expect(page).to have_content("Age: #{pet_1.age}")
      expect(page).to have_content("Sex: #{pet_1.sex}")
      expect(page).to have_content("Status: #{pet_1.status}")
      expect(page).to have_content("Description: #{pet_1.description}")
    end

    describe 'should have 2 links one to update and one to delete' do
     it 'Should have a link to update' do
        shelter_1 = Shelter.create(name: 'AOA',
                                   address: '6254',
                                   city: 'Miami',
                                   state: 'CH',
                                   zip: '636')
        pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                           name: 'Max',
                           age: '3',
                           sex: 'male',
                           description: 'test',
                           status: 'Adoptable',
                           shelter_id: "#{shelter_1.id}")

        visit "/pets/#{pet_1.id}"
        expect(page).to have_link("Update Pet")
        click_link("Update Pet")
        expect(current_path).to eq("/pets/#{pet_1.id}/edit")
      end

      it "Should have link to delete" do
        shelter_1 = Shelter.create(name: 'AOA',
                                    address: '6254',
                                    city: 'Miami',
                                    state: 'CH',
                                    zip: '636')
        pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                            name: 'Max',
                            age: '3',
                            sex: 'male',
                            description: 'test',
                            status: 'Adoptable',
                            shelter_id: "#{shelter_1.id}")

        visit "/pets/#{pet_1.id}"
        expect(page).to have_link("Delete Pet")
        click_link("Delete Pet")
        expect(current_path).to eq("/pets")
      end
    end
    it 'can see a link to view all applicants for pet' do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                         name: 'Max',
                         age: '3',
                         sex: 'male',
                         description: 'test',
                         status: 'Adoptable',
                         shelter_id: "#{shelter_1.id}")
      user_1 = User.create(name: 'Mike Dao',
                            address: '6254',
                            city: 'Miami',
                            state: 'CH',
                            zip: '636')
      application_1 = Application.create(description: "I love dogs",
                                          status: "In Progress",
                                          user_id: user_1.id)
      PetsApplication.create(pet_id: pet_1.id, application_id: application_1.id, status: 'Pending')
      visit "/pets/#{pet_1.id}"

      expect(page).to have_link("View all applicants")

      click_link "View all applicants"

      expect(page).to have_link("Mike Dao")

      click_link("Mike Dao")

      expect(current_path).to eq("/applications/#{application_1.id}")
    end
    it 'can see a message stating there are no applicants for a pet that has not be applied for yet' do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                         name: 'Max',
                         age: '3',
                         sex: 'male',
                         description: 'test',
                         status: 'Adoptable',
                         shelter_id: "#{shelter_1.id}")
      visit "/pets/#{pet_1.id}"

      click_link "View all applicants"

      expect(page).to have_content("There are no applications for this pet")
    end
    it 'cannot delete a pet if it an approved application on them' do
      shelter_1 = Shelter.create(name: 'AOA',
                                 address: '6254',
                                 city: 'Miami',
                                 state: 'CH',
                                 zip: '636')
      pet_1 = Pet.create(image: 'https://expertphotography.com/wp-content/uploads/2019/11/Cute-Kitten-Picture-get-your-cat-to-look-at-the-camera.jpg',
                         name: 'Max',
                         age: '3',
                         sex: 'male',
                         description: 'test',
                         status: 'Adoptable',
                         shelter_id: "#{shelter_1.id}")
      user_1 = User.create(name: 'Mike Dao',
                            address: '6254',
                            city: 'Miami',
                            state: 'CH',
                            zip: '636')
      application_1 = Application.create(description: "I love dogs",
                                          status: "Approved",
                                          user_id: user_1.id)
      PetsApplication.create(pet_id: pet_1.id, application_id: application_1.id, status: 'Approved')
      visit "/pets/#{pet_1.id}"

      click_link("Delete Pet")

      expect(page).to have_content("Pet cannot be deleted because it has been approved for adoption")
    end
  end
end
