function vg -d "convenience function for vagrant"
  if test "$argv"
    command vagrant $argv
  else
    command vagrant status
  end
end
