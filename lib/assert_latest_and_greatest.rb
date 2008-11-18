
module AssertLatestAndGreatest
  
  #  This collects every model in the given class that appears while its block runs
  def assert_latest(*models, &block)
    models, diagnostic = _get_latest_args(models, 'assert')
    latests = get_latest(models, &block)
    latests.compact.length == models.length or
      _flunk_latest(models, latests, diagnostic, true, block)
    return *latests
  end

  def _get_latest_args(models, what) #:nodoc:
    diagnostic = nil
    diagnostic = models.pop if models.last.kind_of? String

    unless models.length > 0 and
            (diagnostic.nil? or diagnostic.kind_of? String)
      raise "call #{ what }_latest(models..., diagnostic) with any number " +
            'of Model classes, followed by an optional diagnostic message'
    end
    return models, diagnostic
  end
  private :_get_latest_args

  def deny_latest(*models, &block)
    models, diagnostic = _get_latest_args(models, 'deny')
    latests = get_latest(models, &block)
    return if latests.compact.empty?
    models = [latests].flatten.compact.map(&:class)
   _flunk_latest(models, latests, diagnostic, false, block)
  end

  def get_latest(models, &block)
    max_ids = models.map{|model| model.maximum(:id) || 0 }
    block.call
    index = -1
    return models.map{|model|
      any = *model.find( :all,
                        :conditions => "id > #{max_ids[index += 1]}",
                        :order => "id asc" )
      any  # * returns nil for [],
           #   one object for [x],
           #   or an array with more than one item
    }
  end

  def _flunk_latest(models, latests, diagnostic, polarity, block) #:nodoc:
    model_names = models.map(&:name)
    model_names.each_with_index do |it, index|
      model_names[index] = nil if !!latests[index] == polarity
    end
    model_names = model_names.compact.join(', ')
    rationale = "should#{ ' not' unless polarity
                 } create new #{ model_names
                 } record(s) in block:\n\t\t#{
                    reflect_source(&block).gsub("\n", "\n\t\t")
                 }\n"
#                 RubyNodeReflector::RubyReflector.new(block, false).result }"
                 # note we don't evaluate...
    flunk build_message(diagnostic, rationale)
  end
  private :_flunk_latest
  
end