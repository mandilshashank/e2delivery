require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def test_get_distance
    assert_equal('7.4 mi', OrdersController.get_distance("95035","94089"))
  end
end
