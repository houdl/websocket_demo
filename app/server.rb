# app.rb
require 'faye/websocket'

App = lambda do |env|
  if Faye::WebSocket.websocket?(env)
    ws = Faye::WebSocket.new(env)

    ws.on :open do |event|
      p '-------server on open --------------'
      ws.send("server sent to client on open")
    end

    ws.on :message do |event|
      p '-------server on message --------------'
      p event.data
    end

    ws.on :close do |event|
      p '-------server on close --------------'
      p [:close, event.code, event.reason]
      ws = nil
    end

    # Return async Rack response
    ws.rack_response

  else
    # Normal HTTP request
    [200, {'Content-Type' => 'text/plain'}, ['Hello']]
  end
end