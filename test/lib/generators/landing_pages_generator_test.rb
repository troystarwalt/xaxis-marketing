require 'test_helper'
require 'generators/landing_pages/landing_pages_generator'

class LandingPagesGeneratorTest < Rails::Generators::TestCase
  tests LandingPagesGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
