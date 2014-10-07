require 'clockwork'

every(10.seconds, 'Queueing interval job') { puts "This is a test" }
