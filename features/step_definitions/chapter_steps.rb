Given(/^he is on some chapter description page$/) do
  @chapter = FactoryGirl.create(:chapter)
  visit chapter_path(@chapter)
end

When(/^he visit a chapter$/) do
  click_on("show-chapter-#{@chapter.id}")
end

Then(/^he can see the description of these chapter$/) do
  page.find("h1").has_text?(@chapter.title)
  current_path.should == chapter_path(@chapter)
  page.should have_text(@chapter.title)
  page.should have_text(@chapter.description)
end

When(/^he is on the chapter page$/) do
  @chapter = FactoryGirl.create(:chapter)
  visit chapters_path
end

When(/^he visit the realisation of these chapter$/) do
  page.should have_link("Réaliser ce chapitre")
  @mission = FactoryGirl.create(:mission)
  @chapter.add_mission(@mission)
  visit chapter_missions_path(chapter_id:  @chapter.id)
end

Given(/^he have already complet some chapters$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^he should see already successed chapters$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^he should see the next chapter to try$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^he can't see other chapters$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^he should see only the first chapter$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^he can see the missions of this chapter$/) do
  page.should have_text(@mission.title)
  page.should have_text(@mission.small_description)
end

When(/^he access to the page for the chapter creation$/) do
  page.should have_link("", href:  new_chapter_path)
  visit new_chapter_path
end

Then(/^he can fill in information of the new chapter$/) do
  @chapter = FactoryGirl.build(:chapter)
  within "#new_chapter" do
    fill_in "chapter_title", with: @chapter.title
    execute_script("$('.wysihtml5-sandbox').contents().find('body').first().html('#{@chapter.description}');
                    $('.wysihtml5-sandbox').contents().find('body').last().html('#{@chapter.small_description}')")
    sleep 5 if @presentation
    find("input[type=submit]").click
  end
end
