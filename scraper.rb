# This is an example to see if your machine is ready to
# do some web scraping with Ruby.
#
# Run this file on the command line with
#
#   bundle exec ruby scraper.rb

# Get our tools
require 'scraperwiki'
require 'mechanize'

# Load up our agent
agent = Mechanize.new

puts "Woot woot, we're all set to go"

# Rest for a moment
sleep 2

# Read in a page
page = agent.get("http://www.frontyardprojects.org/")

# Find somehing on the page using css selectors
puts "You've successfully requested the " + page.at('h1').text + " homepage"

sleep 2
puts "Let's collect all the navigation items"
sleep 2
# For each 'a' element in the '#naviation' element
page.at('#navigation').search('a').each do |a_element|
  record = {
    page_name: a_element.text,
    page_url: a_element[:href]
  }

  puts record
  # Write out to the sqlite database using scraperwiki library
  # the first argument is the attribute that makes this row uniuqe
  # the second argument is the record object to save.
  ScraperWiki.save_sqlite([:page_name], record)
  sleep 0.5
end

3.times do
  puts "..."
  sleep 1
end

puts "We're all done!"
