Given(/^he is on some mission description page$/) do
  @mission = FactoryGirl.create(:mission)
  visit mission_path(@mission)
end

When(/^he visit a mission$/) do
  click_on("show-mission-#{@mission.id}")
end

Then(/^he can see the description of these mission$/) do
  page.find("h1").has_text?(@mission.title)
  current_path.should == mission_path(@mission)
  page.should have_text(@mission.title)
  page.should have_text(@mission.description)
end

When(/^he is on the mission page$/) do
  @mission = FactoryGirl.create(:mission)
  visit missions_path
end

When(/^he visit the realisation of these mission$/) do
  page.should have_link("", :href => new_initialization_program_mission_path(:mission_id => @mission.id))
  visit new_initialization_program_mission_path(:mission_id => @mission.id)
end

Then(/^he can see the snap$/) do
  page.should have_selector("canvas#world")
end

Then(/^he can see the begining of these mission$/) do
  step 'he can see the snap'
  execute_script("typeof world !== 'undefined'")
end

Given(/^he have already complet some missions$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^he should see already successed missions$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^he should see the next mission to try$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^he can't see other missions$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^he should see only the first mission$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^he access to the page for the mission creation$/) do
  page.should have_link("", :href => new_mission_path)
  visit new_mission_path
end

Then(/^he can fill in information of the new mission$/) do
  @mission = FactoryGirl.build(:mission)
  within "#new_mission" do
    fill_in "mission_title", with: @mission.title
    execute_script("$('.wysihtml5-sandbox').contents().find('body').first().html('#{@mission.description}');
                    $('.wysihtml5-sandbox').contents().find('body').last().html('#{@mission.small_description}')")
    sleep 5 if @presentation
    find("input[type=submit]").click
  end
end

Then(/^he can create the program of the mission$/) do
  step 'he can see the begining of these mission'
end
