When(/^I run bundle try "([^"]*)"$/) do |arg|
  run_simple(unescape("ruby -I../../lib ../../exe/bundler-try #{arg}"), false)
end

When(/^I run bundle try "([^"]*)" interactively$/) do |arg|
  run_interactive(unescape("ruby -I../../lib ../../exe/bundler-try #{arg}"))
end

Then(/^I should see the usage\-instructions$/) do
  assert_partial_output("Pick a gem, any gem", all_output)
end

Then(/^a shell should start$/) do
  type("echo $0")
  close_input

  assert_partial_output("bash", all_output)
end

Then(/^the generated Gemfile contains a line "([^"]*)"(?: and a line "([^"]*)")?$/) do |exp1, exp2|
  output_lines = all_output.split("\n")

  expect(output_lines.first).to eq('source "https://rubygems.org"')
  expect(output_lines).to(include(exp1)) &&
    (!exp2 || expect(output_lines).to(include(exp2)))
end
