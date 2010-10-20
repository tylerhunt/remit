# figure out where we are being loaded from
if $LOADED_FEATURES.grep(/spec\/units\/units_helper\.rb/).any?
  begin
    raise "foo"
  rescue => e
    puts <<-MSG
  ===================================================
  It looks like units/units_helper.rb has been loaded
  multiple times. Normalize the require to:

    require "spec/units/units_helper"

  Things like File.join and File.expand_path will
  cause it to be loaded multiple times.

  Loaded this time from:

    #{e.backtrace.join("\n    ")}
  ===================================================
    MSG
  end
end

# Actual code of Units Helper below:
require File.dirname(__FILE__) + '/../spec_helper'
