class StreamsController < ApplicationController
  protect_from_forgery :except => :new
  
  def new
    key = request.headers['key']
    device = Device.find_by_key(key) if key

    # @TODO: verify if json is valid.
    #begin
    #  !!JSON.parse(key)
    #rescue
    #  render status: :bad_request
    #end
    
    if device
      device.streams.create(body: request.body.read)
      render status: :ok
    else
      render status: :bad_request
    end
  end

  def list
    id = params[:id]

    begin
      device = Device.find(id) if id
      
      @streams = device.streams.select(:body,:created_at,:id).limit(100).map do |stream|
        stream.body = JSON.parse(stream.body)
        stream
      end

      render json: @streams
    rescue ActiveRecord::RecordNotFound
      render json: {}
    end

    
    #respond_to do |format|
    #   format.json { render json: @device.errors }
    #end

  end
end
