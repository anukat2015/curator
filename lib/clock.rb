require 'clockwork'

include Clockwork

every(30.minutes, 'Queueing interval job') { puts "30 minutes later" }
