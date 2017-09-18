require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test "Cannot save unless one language is selected" do
    a = Application.new(language_en: false, language_de: false)
    a.save
    assert_equal ["Please select at least one language."], a.errors[:language]
  end

  test "Save if one language is selected" do
    a = Application.new(language_en: true, language_de: false)
    a.save
    assert_equal [], a.errors[:language]
  end

  test "Save if both languguages are saved" do
    a = Application.new(language_en: true, language_de: true)
    a.save
    assert_equal [], a.errors[:language]
  end
end
