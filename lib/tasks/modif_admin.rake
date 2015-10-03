require 'rake'

task :modif_admin, [:firstname, :lastname, :email, :pass] => [:environment] do |t, args|
  u = User.first
  u.firstname = args[:firstname]
  u.lastname = args[:lastname]
  u.email = args[:email]
  u.password = args[:pass]
  u.password_confirmation = args[:pass]
  u.save!
end
