After('@presentation') do
  print "Press Return to continue ..."
  STDIN.getc
end

AfterStep('@presentation') do
  sleep 2
end

Before('@presentation') do
  @presentation = true
end
