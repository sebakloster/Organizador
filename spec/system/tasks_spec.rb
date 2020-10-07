require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let(:user) { create :user }
  before(:each) { sign_in user }

  describe 'GET /tasks' do
    it 'has a correct title' do
      visit '/tasks'
      expect(page).to have_content 'Lista de Tareas'
    end
  end

  describe 'POST /tasks' do
    let!(:category) { create :category }
    let!(:participant) { create :user }
    it 'creates the task using the form', js: true do
      visit '/tasks/new'
      fill_in 'task[name]', with: 'Test 2'
      fill_in 'task[description]', with: 'Mi desc'
      fill_in 'task[due_date]', with: Date.today + 5.day
      select category.name, from: 'task[category_id]'

      click_link 'Agregar un participante'
      xpath = '/html/body/div/div[2]/div/div/form/div[1]/div[4]/div[1]'

      within(:xpath, xpath) do
        select participant.email, from: 'Usuario'
        select 'responsible', from: 'Rol'
      end

      click_button 'Crear Task'
      expect(page).to have_content('Task was successfully created')
    end
  end
end
