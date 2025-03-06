module PrairieLearnHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
  def course_root_path(course_name)
    visit $PL_HOME
    link_to_course = page.find('a', text: course_name, exact_text: true) or
      raise RuntimeError.new("Cannot find link for course '#{course_name}' at #{$PL_HOME}")
    link_to_course[:href]
  end
  def question_path(qid, variant_seed=nil)
    variant_seed ?
      "course_admin/questions/qid/#{qid}?variant_seed=#{variant_seed}" :
      "course_admin/questions/qid/#{qid}"
  end
end

World(PrairieLearnHelpers)

Given /question "(.*)" in course "(.*)"/ do |qid,course_name|
  question_path = [course_root_path(course_name), question_path(qid)].join('/')
  visit question_path
end

Given /variant "(.*)" of question "(.*)" in course "(.*)"/ do |variant,qid,course_name|
  question_path = [course_root_path(course_name), question_path(qid, variant)].join('/')
  visit question_path
end



When /^(?:|I )select "([^\"]*)" from "([^\"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    select(value, :from => field)
  end
end

When /I supply the following answers:/ do |fields|
  fields.rows_hash.each do |name, input_type, value|
    case input-type
    when 'dropdown'
      steps %Q{When I select "#{value}" from "#{name}"}
    when 'text'
    end
  end

end

Then /the overall score should be ([0-9.]+)/ do |score|

end

Then /show me the page/ do
  screenshot_and_open_image
end
Then /save a screenshot/ do
  screenshot_and_save_page
end

