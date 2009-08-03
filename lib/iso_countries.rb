require "rubygems"
%w(activesupport activerecord actionpack actionmailer activeresource).each do |stub|
  require stub
end

require "country_list"
require "iso/countries/form_helpers"
require "iso/countries/country_field"
ActiveRecord::Base.send :include, ISO::Countries::CountryField

module ISO
  module Countries    
    module ClassMethods      
      # Wrapper to get country name from country code. +code+ can be a symbol or a string containing the country code.
      def get_country(code)
        COUNTRIES[code.to_sym] rescue nil
      end
      
      # Wrapper to get country code from country name.
      def get_code(name)
        if COUNTRIES.value?(name)
          COUNTRIES.each_pair do |k,v|
            if v.eql?(name)
              return k.to_s
            end
          end
        end
      end
          
      # Returns an array with all the available country codes
      def country_codes
        COUNTRIES.keys.map { |key| key.to_s }
      end
    end  
    
    class << self
      include ClassMethods
    end
  end
end