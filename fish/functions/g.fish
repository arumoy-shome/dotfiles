function g -d "without arguments call git status else delegate to git"
  # NOTE: assuming topic git is installed in the recommended way in which case
  # hub is also installed.
  if test "$argv"
    command hub $argv
  else
    command hub status
  end
end
