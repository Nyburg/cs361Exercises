Create a repository (or a new subdirectory in an existing one) with a README.md and an empty main.rb. Open your empty main.rb in your editor, and take the following code and paste it into your editor.

#-------------------------------------------------------------
# Exercise 5 Part 1 (Exception Handling)
#-------------------------------------------------------------

class MentalState
  def auditable?
    # true if the external service is online, otherwise false
  end
  def audit!
    # Could fail if external service is offline
  end
  def do_work
    # Amazing stuff...
  end
end

def audit_sanity(bedtime_mental_state)
  return 0 unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

if audit_sanity(bedtime_mental_state) == 0
  puts "error"
else
  new_state = audit_sanity(bedtime_mental_state)
end

#-------------------------------------------------------------
# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)
#-------------------------------------------------------------

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

def audit_sanity(bedtime_mental_state)
  return nil unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

new_state = audit_sanity(bedtime_mental_state)
new_state.do_work

#-------------------------------------------------------------
# Exercise 5 Part 3 (Wrapping APIs)
#-------------------------------------------------------------

require 'candy_service'

machine = CandyMachine.new
machine.prepare

if machine.ready?
  machine.make!
else
  puts "sadness"
end
Now, modify the code to reflect the principles from Clean Code, chapters 7 and 8.