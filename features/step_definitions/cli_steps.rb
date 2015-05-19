Then(/^I should see the usage\-instructions$/) do
  assert_partial_output("Pick a gem, any gem", all_output)
end

Then(/^the generated Gemfile contains a line "([^"]*)"(?: and a line "([^"]*)")?$/) do |exp1, exp2|
  output_lines = all_output.split("\n")
  expect(output_lines).to(include(exp1)) &&
    (!exp2 || expect(output_lines).to(include(exp2)))
end
