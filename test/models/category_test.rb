require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "test takes in string" do
    assert categories(:one).name.eql?("Desert")
  end 
end
