module Rack::Less
  
  # Handles configuration for Rack::Less
  # Available config settings:
  # :cache
  #   whether to cache the compilation output to
  #   a corresponding static file. Also determines
  #   what value config#combinations(:key) returns
  # :compress
  #   whether to remove extraneous whitespace from
  #   compilation output
  # :combinations
  #   Rack::Less uses combinations as directives for
  #   combining the output of many stylesheets and
  #   serving them as a single resource.  Combinations
  #   are defined using a hash, where the key is the
  #   resource name and the value is an array of
  #   names specifying the stylesheets to combine
  #   as that resource.  For example:
  #     Rack::Less.config.combinations = {
  #       'web'    => ['reset', 'common', 'app_web'],
  #       'mobile' => ['reset', 'iui', 'common', 'app_mobile']
  #     }
  # :cache_bust
  #   whether to append a timestamp to the sheet requests generated by combinations
  class Config
    
    ATTRIBUTES = [:cache, :compress, :combinations, :cache_bust]
    attr_accessor *ATTRIBUTES
    
    DEFAULTS = {
      :cache        => false,
      :compress     => false,
      :combinations => {},
      :cache_bust   => false
    }

    def initialize(settings={})
      ATTRIBUTES.each do |a|
        instance_variable_set("@#{a}", settings[a] || DEFAULTS[a])
      end
    end
    
    # <b>DEPRECATED:</b> Please use <tt>cache_bust</tt> instead.
    def combination_timestamp
      warn "[DEPRECATION] `combination_timestamp` is deprecated.  Please use `cache_bust` instead."
      cache_bust
    end
    
    # <b>DEPRECATED:</b> Please use <tt>cache_bust=</tt> instead.
    def combination_timestamp=(value)
      warn "[DEPRECATION] `combination_timestamp=` is deprecated.  Please use `cache_bust=` instead."
      cache_bust = value
    end
    
    def cache?
      !!@cache
    end
    
    def compress?
      !!@compress
    end
    
    def combinations(key=nil)
      if key.nil?
        @combinations
      else
        if cache?
          stylesheet_filename(key)
        else
          (@combinations[key] || []).collect do |combo|
            stylesheet_filename(combo)
          end
        end
      end
    end
    
    def stylesheet(key)
      if @combinations[key]
        combinations(key.to_s)
      else
        stylesheet_filename(key.to_s)
      end
    end

    private
    
    def stylesheet_filename(key)
      filename = key.strip
      filename += ".css" unless filename.include?('.css')
      if !filename.include?('?') && cache_bust
        filename += "?"
        filename += if cache_bust == true
          Time.now.to_i
        else
          cache_bust
        end.to_s
      end
      filename
    end
    
  end
end