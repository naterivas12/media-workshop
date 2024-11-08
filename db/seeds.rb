require 'faker'
puts "Start seeding"

puts "Seeding users"
User.destroy_all
User.create(username: "admin", email: "admin@mail.com", password: "letmein", role: "admin")
User.create([
  {username: "testino", email: "testino@mail.com", password: "letmein"},
  {username: "probino", email: "probino@mail.com", password: "letmein"},
])

puts "Seeding articles"
Article.destroy_all
5.times do |n|
  article = Article.new(title: Faker::Lorem.sentence, body: Faker::Markdown.sandwich(sentences: 5))
  article.user = User.contributor.sample
  url = Faker::LoremFlickr.image
  article.cover.attach(io: URI.open(url), filename: "article-#{n}.jpg")
  if article.save
    rand(2..5).times do
      comment = article.comments.new(body: Faker::Lorem.sentence, user: User.contributor.sample)
      puts comment.errors.full_messages unless comment.save
    end
  else
    puts article.errors.full_messages
  end

end
