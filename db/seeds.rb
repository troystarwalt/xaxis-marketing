
if Rails.env.production?
  brands = ['Xaxis', 'plista', 'Light Reaction', 'Triad']
  brands.each do |brand_name|
    Brand.find_or_initialize_by(name: brand_name, &:save)
    puts 'created or updated ' + brand_name
  end

  platforms = %w(Turbine Spotlight Xanadu)

  platforms.each do |platform_name|
    Platform.find_or_initialize_by(name: platform_name, &:save)
    puts 'created or updated ' + platform_name
  end

  puts '<<<<<<<<<<------------ Production Database Seeded With Amazing Data ----------->>>>>>>>>>>>>'
end

if Rails.env.development? || Rails.env.test?
  Post.destroy_all
  Brand.destroy_all
  Platform.destroy_all

  50.times do
    Post.create!(
      title: Faker::Book.title,
      text: Faker::Lorem.paragraph(2),
      author: Faker::GameOfThrones.character
    ).tap do |post|
      post.tag_list.add Post.valid_tags.sample
      post.save
    end
  end

  puts 'posts created'
  AdminUser.destroy_all
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  brands = ['Xaxis', 'plista', 'Light Reaction', 'Triad']
  categories = %w(ppt_template word_template font guidelines logo capability palette facts)
  headshot_photo = ['public/seedfiles/female.jpg', 'public/seedfiles/male.jpg']

  brands.each do |brand_name|
    brand = Brand.create(name: brand_name)
    categories.each do |cat|
      brand.brand_accessories.create(name: Faker::Superhero.name,
                                    file: open('public/seedfiles/pdf-seed.pdf'),
                                    category: cat, brand_id: brand.id)
      puts 'created ' + cat
    end
    10.times do
      Headshot.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        title: Faker::Name.title,
        brand_id: brand.id,
        priority: Faker::Number.between(1, 20),
        image: open(headshot_photo.sample)
      )
    end
    puts '---------------'
    puts 'created ' + brand_name
  end

  video_embed = '<iframe src="https://player.vimeo.com/video/149429953" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
  <p><a href="https://vimeo.com/149429953">The Xaxis Advantage</a> from <a href="https://vimeo.com/xaxis">Xaxis</a> on <a href="https://vimeo.com">Vimeo</a>.</p>'
  video_direct = 'https://vimeo.com/149429953'

  platforms = %w(Turbine Spotlight Xanadu)
  platforms.each do |platform_name|
    platform = Platform.create(name: platform_name)
    platform.logos.create(name: Faker::Hacker.adjective, file: open('public/seedfiles/logo-seed.png'))
    platform.logos.create(name: Faker::Hacker.adjective, file: open('public/seedfiles/eps-seed.eps'))
    2.times do
      platform.infographics.create(name: Faker::Hacker.adjective, description: Faker::Hipster.paragraph, image_preview: open('public/seedfiles/logo-seed.png'), file: open('public/seedfiles/pdf-seed.pdf'))
    end
    platform.one_sheeters.create(name: Faker::Hacker.adjective, file: open('public/seedfiles/pdf-seed.pdf'))
    4.times do
      platform.videos.create(name: Faker::StarWars.planet, description: Faker::Hipster.paragraph, direct_link: video_direct, embed_link: video_embed)
    end
    puts 'created ' + platform_name
  end

  platform_ids = Platform.pluck(:id)

  POSSIBLE_TAGS = %w(
    Advertisting
    Automotive
    Business
    Pleasure
    Film
    Digital
    Computer
    Direct
    Outcomes
  ).freeze

  REGIONS = [
    'APAC',
    'EMEA',
    'Latam',
    'North America'
  ].freeze

  20.times do
    CaseStudy.create(
      author: Faker::Book.author,
      release_date: Faker::Time.backward(20, :morning),
      short_description: Faker::Hipster.paragraph,
      pdf_attachment: open('public/seedfiles/pdf-seed.pdf'),
      title: Faker::Commerce.product_name,
      platform_id: platform_ids.sample,
      industry_list: POSSIBLE_TAGS.shuffle.take(rand(1..4)),
      region_list: REGIONS.shuffle.take(rand(1..4))
    )
  end
  puts 'case studies created'

  EXPERT_INTERVIEWS = [
    {
      vimeo_url: 'https://player.vimeo.com/video/163831474?autoplay=1&api=1',
      image: File.open(Rails.root + 'app/assets/images/landing_pages/expert_interview_hub/video_thumbs/turbine_predict_future.jpg'),
      contributor_name: 'Jon Whitticom',
      contributor_title: 'VP, Product Development, Xaxis',
      title: 'comScore’s Audience Validation Audit and What It Means for Xaxis',
      description: 'Xaxis collaborated with comScore to conduct a global audit of Turbine audiences to access their predictive accuracy. Through this, we validated our ability to predict future consumer behavior through Turbine and have outpaced the competition in similar studies by 20%. Why is this important? Jon Whitticom explains the significance of the comScore audit and how it impacts the future of Turbine for us and our clients.'
    },
    {
      vimeo_url: 'https://player.vimeo.com/video/166802006?autoplay=1&api=1',
      image: File.open(Rails.root + 'app/assets/images/landing_pages/expert_interview_hub/video_thumbs/audience_beyond_boundaries.jpg'),
      contributor_name: 'Sarah Warner',
      contributor_title: 'VP, Investments &amp; Partnerships, Xaxis',
      title: 'Audiences Beyond Boundaries: The Xaxis and Google Partnership',
      description: 'Making the world flat by bringing Turbine Data into new environments has been a key Xaxis focus for 2016. Through the partnership between Xaxis, WPP and Google, we are now able to apply Turbine audience data to programmatically buy Google inventory via DBM. Learn more about this partnership through the words of Sarah Warner, explaining all you need to know on this exciting news.'

    },
    {
      vimeo_url: 'https://player.vimeo.com/video/175274585?autoplay=1&api=1',
      image: File.open(Rails.root + 'app/assets/images/landing_pages/expert_interview_hub/video_thumbs/achieving_real_outcomes.jpg'),
      contributor_name: 'Bob Walczak',
      contributor_title: 'CEO, Light Reaction',
      title:  'Achieving Real Outcomes: The New Light Reaction Story',
      description: 'It’s an exciting time for Light Reaction as we move towards our new positioning of Real Outcomes, which combine proprietary media, data and technology at scale. CEO, Bob Walczak speaks to this new positioning, providing you with important information about it and how you can integrate it into your Xaxis elevator pitch. Watch this video to learn all about real outcomes and understand how to position Light Reaction moving forward.'
    },
    {
      vimeo_url: 'https://player.vimeo.com/video/178067899?autoplay=1&api=1',
      image: File.open(Rails.root + 'app/assets/images/landing_pages/expert_interview_hub/video_thumbs/creativity.jpg'),
      contributor_name: 'David J. Moore',
      contributor_title: 'Chairman of Xaxis &amp; President, WPP Digital',
      title: 'A Conversation on Creative: The Convergence of Programmatic and Creativity',
      description: 'With the recent occurrence of the Cannes Lions Festival, the industry focus went to the buzz-worthy topic of creativity. David J. Moore discusses this topic and its relevance to how it is converging with programmatic and the future that Dynamic Creative Optimization in our industry.'
    },
    {
      vimeo_url: 'https://player.vimeo.com/video/187838940?autoplay=1&api=1',
      image: File.open(Rails.root + 'app/assets/images/landing_pages/expert_interview_hub/video_thumbs/smart-data.png'),
      contributor_name:  'Nicole Pangis',
      contributor_title: 'Global COO, Xaxis',
      title: 'Making Data Smart: What It Means And Why It Matters',
      description: 'Have you ever asked, what makes data smart? Global COO, Nicolle Pangis has the answer for you! Between the differences and initiatives from big data to smart data, to how smart data impacts and benefits client campaigns, and the future of data becoming smarter in our industry, this video will provide you with all you need to know on smart data as we move toward revolutionizing data use.'
    }
  ].freeze

  EXPERT_INTERVIEWS.each do |ei|
    ExpertInterview.create(ei)
  end

  puts 'Expert Interviews Created'
  puts '<<<<<<<<<<------------ Development Database Seeded With Amazing Data ----------->>>>>>>>>>>>>'
end

if ENV["series"]
  20.times do
    OneOhOne.create!(name: Faker::Book.title,
                      ppt_file: open('public/seedfiles/ppt-seed.pptx'),
                      pdf_file: open('public/seedfiles/pdf-seed.pdf'),
                      image_preview: open('public/seedfiles/img-seed.png'))
  end
end
