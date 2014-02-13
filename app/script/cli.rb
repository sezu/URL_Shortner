#Ask the user for their email; find the User with this email.
#You don't have to support users signing up through the CLI.
#Give the user the option of visiting a shortened URL or creating one.
#When they create a new short URL, return to the user the short url.
#Use the launchy gem to open a URL in the browser; record a visit.

def ask_for_email
  puts "Input your email:"

  email = gets.chomp
  user = User.find_by_email(email)
  user = User.create!(:email => email) unless user

  user
end

def main_menu
  puts "What do you want to do?"
  puts "0. Create shortened URL"
  puts "1. Visit shortened URL"
  puts "2. Quit."

  gets.chomp
end

def process_input(input, user)
  if input == "0"
    create_shortened_url(user)
  elsif input == "1"
    visit_shortened_url(user)
  else
    puts "Bye bye bye"
    true
  end
end

def create_shortened_url(user)
  puts "Type in your long url"

  long_url = gets.chomp
  url = ShortenedUrl.create_for_user_and_long_url!(user, long_url)

  puts "Short url is: #{url.short_url}"

  false
end

def visit_shortened_url(user)
  puts "Type in the shortened URL"

  short_url = gets.chomp
  url = ShortenedUrl.find_by_short_url(short_url)
  Launchy.open(url.long_url)

  Visit.record_visit!(user, url)

  false
end


user = ask_for_email

done = false

until done
  input = main_menu
  done = process_input(input, user)
end

