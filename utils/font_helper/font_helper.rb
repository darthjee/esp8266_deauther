lib = File.expand_path('source', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'font_helper'

case ARGV.first
when 'script'
  FontHelper::Script.new(ARGV.second).run
end
