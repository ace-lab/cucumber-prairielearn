module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

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
      steps %Q{When I 
  end

end

Then /the overall score should be ([0-9.]+)/ do |score|

end

