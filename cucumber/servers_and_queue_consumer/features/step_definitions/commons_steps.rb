Given(/^I logged on admin of rabbitmq$/) do
  visit("http://localhost:15672")
  fill_in 'username', with: 'guest'
  fill_in 'password', with: 'guest'
  click_on "Login"
end

Given(/^in page of "([^"]*)" queue$/) do |queue|
  click_on "Queues"
  click_on queue
end

When(/^set the message$/) do |message|
  @message = message
  find('h2', :text => 'Publish message').click
  fill_in 'payload', with: message
end

When(/^set header key "([^"]*)" with "([^"]*)"$/) do |key, value|
  @name = value
  fill_in 'headers_1_mfkey', with: key
  fill_in 'headers_1_mfvalue', with: value
end

When(/^post the message$/) do
  click_on 'Publish message'
end

Then(/^read the message content from service$/) do
  result = HTTParty.get("http://localhost:4567/api/#{@name}", 
                        headers: {'Content-type' => 'text/plain'}).gsub("\r", '').chop
  expect(result).to eql(@message)
end
