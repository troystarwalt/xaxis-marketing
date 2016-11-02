# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.production?
  brands = ["Xaxis", "plista", "Light Reaction", "Triad"]

  brands.each do |brand_name|
    Brand.find_or_initialize_by(name: brand_name) do |brand|
      brand.save
    end
    puts "created or updated " + brand_name
  end

  platforms = ["Turbine", "Spotlight", "Xanadu"]

  platforms.each do |platform_name|
    Platform.find_or_initialize_by(name: platform_name) do |platform|
      platform.save
    end
    puts "created or updated " + platform_name
  end

  puts "<<<<<<<<<<------------ Production Database Seeded With Amazing Data ----------->>>>>>>>>>>>>"


end

if Rails.env.development? || Rails.env.test?
  Post.destroy_all
  Brand.destroy_all
  Platform.destroy_all

  50.times do
    tags = Post.valid_tags
    Post.create!(
      title: Faker::Book.title,
      text: Faker::Lorem.paragraph(2),
      author: Faker::GameOfThrones.character
    ).tap do |post|
      post.tag_list.add Post.valid_tags.sample
      post.save
    end
  end

  puts "posts created"
  AdminUser.destroy_all
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  brands = ["Xaxis", "plista", "Light Reaction", "Triad"]
  categories = ["ppt_template", "word_template", "font", "guidelines", "logo", "capability", "palette", "facts"]
  headshot_photo = ["public/seedfiles/female.jpg", "public/seedfiles/male.jpg"]


  brands.each do |brand_name|
    brand = Brand.create(:name => brand_name)
    categories.each do |cat|
      brand.brand_accessories.create(name: Faker::Superhero.name, file: open("public/seedfiles/pdf-seed.pdf"), category: cat, brand_id: brand.id)
      puts "created " + cat
    end
    10.times do
      Headshot.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        title: Faker::Name.title,
        brand_id: brand.id,
        priority: Faker::Number.between(1, 20),
        image: open(headshot_photo.sample))
    end
    puts "---------------"
    puts "created " + brand_name
  end

  video_embed = '<iframe src="https://player.vimeo.com/video/149429953" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
  <p><a href="https://vimeo.com/149429953">The Xaxis Advantage</a> from <a href="https://vimeo.com/xaxis">Xaxis</a> on <a href="https://vimeo.com">Vimeo</a>.</p>'
  video_direct = "https://vimeo.com/149429953"


  platforms = ["Turbine", "Spotlight", "Xanadu"]
  platforms.each do |platform_name|
    platform = Platform.create(:name => platform_name)
      platform.logos.create(name: Faker::Hacker.adjective, file: open("public/seedfiles/logo-seed.png"))
      platform.logos.create(name: Faker::Hacker.adjective, file: open("public/seedfiles/eps-seed.eps"))
      2.times do
        platform.infographics.create(name: Faker::Hacker.adjective, description: Faker::Hipster.paragraph, image_preview: open("public/seedfiles/logo-seed.png"), file: open("public/seedfiles/pdf-seed.pdf"))
      end
      platform.one_sheeters.create(name: Faker::Hacker.adjective, file: open("public/seedfiles/pdf-seed.pdf"))
      4.times do
        platform.videos.create(name: Faker::StarWars.planet, description: Faker::Hipster.paragraph, direct_link: video_direct, embed_link: video_embed)
      end
    puts "created " + platform_name
  end

  platform_ids = Platform.pluck(:id)

  POSSIBLE_TAGS = [
    "Advertisting",
    "Automotive",
    "Business",
    "Pleasure",
    "Film",
    "Digital",
    "Computer",
    "Direct",
    "Outcomes"
  ].freeze

  20.times do
    CaseStudy.create(
    author: Faker::Book.author,
    release_date: Faker::Time.backward(20, :morning),
    short_description: Faker::Hipster.paragraph,
    pdf_attachment: open("public/seedfiles/pdf-seed.pdf"),
    title: Faker::Commerce.product_name,
    platform_id: platform_ids.sample,
    industry_list: POSSIBLE_TAGS.shuffle.take(3)
    )
  end
  puts "case studies created"
  puts "<<<<<<<<<<------------ Development Database Seeded With Amazing Data ----------->>>>>>>>>>>>>"
end
