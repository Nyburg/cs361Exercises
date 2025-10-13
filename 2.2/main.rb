#Name Mangler cleaned up

def reverse_name(full_name)
  full_name.split.reverse.join(" ")
end

def borgify(full_name)
  parts = full_name.split
  (parts + ["Borg"]).join(" ")
end

def modified_name(full_name, mode = :reverse)
  case mode
  when :reverse then reverse_name(full_name)
  when :borg    then borgify(reverse_name(full_name))
  else
    raise ArgumentError, "unknown mode: #{mode}"
  end
end

if $PROGRAM_NAME == __FILE__
  name = "Johanna Jackson"
  puts "New name: #{modified_name(name, :reverse)}"
  puts "New borg name: #{modified_name(name, :borg)}"
end