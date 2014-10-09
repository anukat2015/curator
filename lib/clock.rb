require 'clockwork'

include Clockwork

every(30.minutes, 'Queueing interval job') { puts "This is a test" }
