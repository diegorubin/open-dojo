Given(/^I logged on admin of rabbitmq$/) do
  visit("http://localhost:15672")

  field = first('input')

  if field[:name] == 'username'
    fill_in 'username', with: 'guest'
    fill_in 'password', with: 'guest'
    click_on "Login"
  end
end

Given(/^in page of "([^"]*)" queue$/) do |queue|
  click_on "Queues"
  click_on queue
end

When(/^set the message$/) do |message|
  @message = message
  if not find('#headers_1_mfkey', visible: false).visible?
    find('h2', :text => 'Publish message').click
  end
  fill_in 'payload', with: message
end

When(/^set header key "([^"]*)" with "([^"]*)"$/) do |key, value|
  fill_in 'headers_1_mfkey', with: key
  fill_in 'headers_1_mfvalue', with: value
end

When(/^post the message$/) do
  click_on 'Publish message'
end

When(/^fetch "([^"]*)" file from api$/) do |name|
  @response = HTTParty.get("http://localhost:4567/api/#{name}", 
                        headers: {'Content-type' => 'text/plain'})
end

Then(/^the response should be the message$/) do
  expect(@response.body.gsub("\r", "").chop).to eql @message
end

Then(/^the response status code should be "([^"]*)"$/) do |code|
  expect(@response.response.code).to eql code
end

Then(/^a messsage exists on "([^"]*)" queue with "([^"]*)" in payload$/) do |queue, content|
  click_on "Queues"
  click_on queue

  find('h2', :text => 'Get messages').click

  click_on 'Get Message(s)'

  expect(page).to have_content(content)
end

