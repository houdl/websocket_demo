#######
#
# thin start -R ./config.ru -p 7001
# thin start -R ./config.ru -p 7001 -d
#######

require './app/server'

Faye::WebSocket.load_adapter('thin')
run App