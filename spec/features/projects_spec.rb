require "rails_helper"

RSpec.describe User, :type => :model do
  def login_user
    user = FactoryBot.create(:user)
    login_as(user)
  end

feature "Projects", type: :feature do
  context "Create new project" do
    before(:each) do
      login_user
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
      end
      
    end

    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end

    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      login_user
      visit edit_project_path(project)
    end

    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end

    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

context "Remove existing project" do
  let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "remove project" do
      login_user
      visit project_path(project)
      click_button "Destroy this project"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end
end end