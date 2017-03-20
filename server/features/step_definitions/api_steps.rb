Given(/^API v(\d+)$/) do |api_version|
  @app = Api.const_get("V#{api_version}").const_get("Server")
end

Given /^the following modes:$/ do |table|
  repo = Application['modes_repository']
  table.rows.map do |row|
    repo.create(name: row.first, url: row.last)
  end
end

When(/^I hit the root of the API$/) do
  @response = get '/'
end

When(/^I hit the (.+) endpoint$/) do |endpoint|
  @response = get "/#{endpoint}"
end

When(/^[tT]he response is (\d+)$/) do |response_code|
  expect(@response).to_not be_nil
  expect(@response.status).to eq(Integer(response_code))
end

Then(/^[tT]he response is a HAL document$/) do
  expect(@response).to_not be_nil
  expect(@response.body).to be_hal

  @hal_response = parse_hal(@response.body)
end

Then(/^I can discover a (.+) endpoint/) do |relation|
  step "the response is a HAL document"

  expect(@hal_response).to have_relation relation
end

Then(/^I can discover the mode count$/) do
  expect(@hal_response).to have_property "count"
end

Then(/^there are (\d+) modes$/) do |count|
  expect(@hal_response.property('count')).to eq(Integer(count))
end

Then(/^I can see mode (.+)$/) do |mode_name|
  expect(@hal_response).to have_property 'modes'

  modes = @hal_response.property('modes')

  expect(modes.one? {|mode| mode['name'] == mode_name }).to eq(true)
end
