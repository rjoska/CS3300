require 'rails_helper'

#RSpec.feature "HomePags", type: :feature do
 # pending "add some scenarios (or delete) #{__FILE__}"
#end

RSpec.feature "Visiting the homepage", type: :feature do
  scenario "The visitor should see projects" do
    visit root_path
    expect(page).to have_text("Roman Joska Portfolio")
  end
end