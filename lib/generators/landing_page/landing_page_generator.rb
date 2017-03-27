class LandingPageGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :landing_page_name, type: :string, default: "default"
  class_option :stylesheet, type: :boolean, default: :true, desc: "Include stylesheet file."
  class_option :full, type: :boolean, default: :true, desc: "Should the url be xaxis.com/:page?"

  def setup_files
    template "lp.haml", "app/views/landing_pages/#{file_name}.haml"
    template "style.css", "app/assets/stylesheets/#{file_name}.sass" if options.stylesheet?
  end

  def setup_stylesheet
    insert_into_file "app/assets/stylesheets/application.css.sass", "\n@import \"#{file_name}\"\n", after: '"all-hands"'
  end

  def setup_route
    insert_into_file "config/routes.rb", "\n  get '#{file_name_urled}' => 'landing_pages##{file_name}'\n", after: "# Custom Generated Landing Pages" if options.full?
  end

  def setup_action
    insert_into_file "app/controllers/landing_pages_controller.rb", "\n  def #{file_name}\n   # start here\n  end\n", after: "# Landing Pages" if options.full?
  end
  private
  def file_name
    landing_page_name.underscore
  end

  def file_name_urled
    file_name.dasherize
  end
end
