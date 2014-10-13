require 'clockwork'

include Clockwork

every(10.minutes, 'Queueing interval job') { puts "This is a test" }
