require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let(:user) { create :user }
  before(:each) { sign_in user }

  before do
    driven_by(:rack_test)
  end

  describe 'GET /tasks' do
    it 'has a correct title' do
      visit '/tasks'
      expect(page).to have_content 'Lista de Tareas'
    end
  end

  describe 'POST /tasks' do
    let!(:category) { create :category }
    let!(:participant) { create :user }
    it 'creates the task using the form' do
      visit '/tasks/new'
      fill_in 'task[name]', with: 'Test 2'
      fill_in 'task[description]', with: 'Mi desc'
      fill_in 'task[due_date]', with: Date.today + 5.day
      select category.name, from: 'task[category_id]'
      # click_link 'Agregar un participante'
      # select participant.id, from: 'task[participating_users_attributes][0][user_id]'
      click_button 'Crear Task'
      # expect(page).to have_content 'Task was successfully created.'
    end
  end
end
