# == Schema Information
#
# Table name: parameters
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ParameterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
