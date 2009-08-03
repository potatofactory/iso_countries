require 'test/unit'
require "iso_countries"

class IsoCountriesTest < Test::Unit::TestCase
  def test_get_country
    assert_equal("Spain", ISO::Countries.get_country("es"))
  end
  
  def test_get_code
    assert_equal('es', ISO::Countries.get_code('Spain'))
  end
end
