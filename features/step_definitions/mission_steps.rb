When(/^he is on the mission page$/) do
  @mission = FactoryGirl.create(:mission)
  visit missions_path
end

When(/^he visit a mission$/) do
  click_on("show-mission-#{@mission.id}")
end

Then(/^he can see the description of these mission$/) do
  has_text?(@mission.title)
  has_text?(@mission.description)
end

Given(/^he is on some mission page$/) do
  @mission = FactoryGirl.create(:mission)
  visit mission_path(@mission)
end

When(/^he visit the realisation of these mission$/) do
  click_on("mission-program")
end

Then(/^he can see the ide$/) do
  has_css?("canvas#world")
end

Then(/^he can see the begining of these mission$/) do
  pending # express the regexp above with the code you wish you had
end
