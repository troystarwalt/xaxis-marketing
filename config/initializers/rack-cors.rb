## Configure Rack CORS Middleware, so that CloudFront can serve our assets.
## See https://github.com/cyu/rack-cors
puts "not defined ----------------------------------------------"
if defined? Rack::Cors
  puts "dinosaur-------------------------------------------------------------"
    # Rails.configuration.middleware.insert_before 0, Rack::Cors do
    #     allow do
    #         origins %w[
    #             https://marketing.xaxis.com
    #              http://marketing.xaxis.com
    #             https://www.marketing.xaxis.com
    #              http://www.marketing.xaxis.com
    #             https://xaxis-internal-staging.herokuapp.com
    #              http://xaxis-internal-staging.herokuapp.com
    #         ]
    #         resource '/assets/*'
    #     end
    # end
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'

        # All asset requests should be to rails prefixed assets paths
        # serverd from the asset pipeline (e.g.: "/assets/*" by default)
        resource "#{Rails.application.config.assets.prefix}/*",
          # Allow any request headers to be sent in the asset request
          # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS#Access-Control-Allow-Headers
          headers: :any,
          # All asset fetches should be via GET
          # Support OPTIONS for pre-flight requests
          # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS#Preflighted_requests
          methods: [:get, :options]
      end
    end
    byebug
end
