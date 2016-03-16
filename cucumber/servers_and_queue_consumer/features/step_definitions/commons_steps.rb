Given(/^I logged on admin of rabbitmq$/) do
  login_in_rabbit('guest', 'guest')
end

Given(/^in page of "([^"]*)" queue$/) do |queue|
  click_on "Queues"
  click_on queue
end

When(/^set the message with header "([^"]*)" with value "([^"]*)"$/) do |key, value, message|
  @message = message
  publish_message(message, headers: {key => value})
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

