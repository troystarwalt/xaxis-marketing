## Configure Rack CORS Middleware, so that CloudFront can serve our assets.
## See https://github.com/cyu/rack-cors

if defined? Rack::Cors
    Rails.configuration.middleware.insert_before 0, Rack::Cors do
        allow do
            origins %w[
                https://marketing.xaxis.com
                 http://marketing.xaxis.com
                https://www.marketing.xaxis.com
                 http://www.marketing.xaxis.com
                https://xaxis-internal-staging.herokuapp.com
                 http://xaxis-internal-staging.herokuapp.com
            ]
            resource '/assets/*'
        end
    end
end
