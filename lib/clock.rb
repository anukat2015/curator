require 'clockwork'

include Clockwork

every(10.seconds, 'Queueing interval job') { puts "This is a test" }
