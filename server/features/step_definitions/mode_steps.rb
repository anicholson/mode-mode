Given(/^the following mode list:$/) do |table|
  allow(YAML).to receive(:load_file).and_return(modes: table.symbolic_hashes)

  @modes_repo = Application['modes_repository']
end

When(/^I load the modes$/) do
  @pre_load_count = @modes_repo.count
  loader = Application['mode_loader']
  loader.load_modes

  @lol = "Pre: #{@pre_load_count}. Post: #{ @modes_repo.count }"
end

Then(/^There are (\d+) modes$/) do |mode_count|
  expect(@modes_repo.count).to eq(Integer(mode_count) + @pre_load_count)
end
