require 'rubygems'
require 'iso_country_codes'
require 'activerecord'

require "iso/countries/form_helpers"
require "iso/countries/country_field"
ActiveRecord::Base.send :include, ISO::Countries::CountryField

module ISO
  module Countries    
    module ClassMethods      
      
      def country_name_by_code_lookup
        @@country_name_by_code_lookup ||= IsoCountryCodes.all.inject({}) do |hash, code|
          hash[code.alpha2.downcase] = code.name
          hash
        end
      end
      
      def country_code_by_name_lookup
        @@country_code_by_name_lookup ||= IsoCountryCodes.all.inject({}) do |hash, code|
          hash[code.name] = code.alpha2.downcase
          hash
        end        
      end

      # Wrapper to get country name from country code. +code+ can be a symbol or a string containing the country code.
      def get_country(code)
        country_name_by_code_lookup[code.downcase]
      end
      
      # Wrapper to get 2-character country code from country name.
      def get_code(name)
        country_code_by_name_lookup[name].downcase
      end
          
      # Returns an array with all the available 2-character country codes.
      def country_codes
        @@country_codes ||= IsoCountryCodes.all.map { |code| code.alpha2.downcase }
      end      
    end  
    
    class << self
      include ClassMethods
    end
  end
end