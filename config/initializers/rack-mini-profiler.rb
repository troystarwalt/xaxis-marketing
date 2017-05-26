require 'rack-mini-profiler'

Rack::MiniProfilerRails.initialize!(Rails.application)

Rails.application.middleware.swap(Rack::MiniProfiler, nil)
Rails.application.middleware.delete(nil)
Rails.application.middleware.insert_after(Rack::Deflater, Rack::MiniProfiler)
