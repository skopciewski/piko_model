# frozen_string_literal: true
require "test_helper"
require "piko_model"

class PikoModelTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PikoModel::VERSION
  end
end
