# frozen_string_literal: true
module PlatformsHelper

  def platform_description
    if @platform.name === "Turbine"
      "<p>Turbine is our first of its kind data management platform designed for programmatic speed, centralized planning and audience activation.</p>
      <p>Take advantage of the Turbine collateral below including vidoes, one-sheeters, and case studies!</p>"
    elsif @platform.name === "Spotlight"
      "<p>Spotlight is a data visualization & analytic dashboard for centralized campaign insights.</p>
      <p>To help educate your clients on Spotlight’s capabilties see below for one-sheeters and videos!</p>"
    elsif @platform.name === "Xanadu"
      "<p>Xanadu is our data and analytics platform designed for online/offline customer data integration and analysis of historical campaign intelligence.</p>
      <p>Browse our Xaxnadu library below to view vauable sales collateral!</p>"
    else
      "<p>Welcome to our Platforms page.</p>"
    end
  end
end
