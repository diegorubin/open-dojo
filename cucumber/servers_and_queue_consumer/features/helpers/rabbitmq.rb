module Rabbitmq

  def login_in_rabbit(username, password)
    visit("http://localhost:15672")

    field = first('input')

    if field[:name] == 'username'
      fill_in 'username', with: username
      fill_in 'password', with: password
      click_on "Login"
    end
  end

  def publish_message(message, options = {})
    if not find('#headers_1_mfkey', visible: false).visible?
      find('h2', :text => 'Publish message').click
    end
    fill_in 'payload', with: message

    if options.has_key?(:headers)
      options[:headers].each_with_index do |(header, value), index|
        fill_in "headers_#{index + 1}_mfkey", with: header
        fill_in "headers_#{index + 1}_mfvalue", with: value
      end
    end

    click_on 'Publish message'
  end

end

