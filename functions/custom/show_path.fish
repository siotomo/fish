function show_path
  echo 'show user added_path order by priority'
  echo ''

  echo $PATH | tr " " "\n" | nl
end
