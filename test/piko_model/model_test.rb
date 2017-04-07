# frozen_string_literal: true
require "test_helper"
require "piko_model/model"

class FakeModel < PikoModel::Model
  field "f1", default: true
  field "f2.f3", default: :z
  field "f4"
end

class ModelTest < Minitest::Test
  def test_created_model_without_required_fields_should_be_invalid
    model = FakeModel.new
    assert_equal false, model.valid?
  end

  def test_created_model_with_all_fields_should_be_valid
    model = FakeModel.new f4: "foo"
    assert_equal true, model.valid?
  end

  def test_get_default_value_from_model
    model = FakeModel.new
    assert_equal :z, model["f2.f3"]
  end

  def test_get_asigned_value
    model = FakeModel.new f4: "foo"
    assert_equal "foo", model["f4"]
  end

  def test_fetch_assigned_value
    model = FakeModel.new
    assert_equal "foo", model.fetch("f4", "foo")
  end

  def test_conversion_to_hash
    model = FakeModel.new f4: "foo", to_much: 123
    expected = { "f1" => true, "f2.f3" => :z, "f4" => "foo" }
    assert_equal expected, model.to_h
  end

  def test_show_missing_fields
    model = FakeModel.new
    expected = ["f4"]
    assert_equal expected, model.missing_fields
  end
end
