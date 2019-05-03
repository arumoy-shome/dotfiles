function vim -d "use nvim when available"
  if command -sq nvim
    nvim $argv
  else
    vim $argv
  end
end
