require 'nokogiri'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = kickstarter.css(".project-card")

  projects.each_with_object({}) do |project, hash|
    hash[project.css('.bbcard_name a').text.strip] = {
      image_link: project.css('img').attribute('src').value,
      description: project.css('p.bbcard_blurb').text.strip,
      location: project.css('.location-name').text.strip,
      percent_funded: project.css('.funded strong').text.strip[0...-1].to_i
    }
  end
end