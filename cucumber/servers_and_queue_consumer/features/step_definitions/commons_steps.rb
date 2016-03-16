Given(/^estou logado$/) do
  login_in_rabbit('guest', 'guest')
end

Given(/^acesso a fila "([^"]*)"$/) do |arg1|
  click_on 'Queues'
  click_on 'dojo'
end

When(/^seto o header "([^"]*)" e com valor "([^"]*)"$/) do |header, value|
  @value = value
  if not find('#headers_1_mfkey', visible: false).visible?
    find('h2', :text => 'Publish message').click
  end

  fill_in 'headers_1_mfkey', with: header
  fill_in 'headers_1_mfvalue', with: value
end

When(/^digito a mensagem "([^"]*)"$/) do |message|
  @message = message
  fill_in 'payload', with: message
end

When(/^clico em enviar$/) do
  click_on 'Publish message'
end

Then(/^mensagem eh postada$/) do
  expect(page).to have_content('Message published.')
end

Then(/^o serviço deve retornar o conteúdo postado$/) do
  response = HTTParty.get('http://localhost:4567/api/valor')
  expect(response.body.chop).to eql(@message)
end

Then(/^o serviço deve retornar "([^"]*)"$/) do |statuscode|
  response = HTTParty.get("http://localhost:4567/api/#{@value}")
  expect(response.code).to eql(statuscode.to_i)
end
