module ActionView #:nodoc:
  module Helpers #:nodoc:
    module FormOptionsHelper
      # Return select and option tags for the given object and method, using iso_options_for_select to generate the list of option tags.
      def country_select(object, method, priority_countries = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_country_select_tag(priority_countries, options, html_options)
      end

      # Returns a string of option tags for pretty much any country in the world. Supply a country name as selected to have it marked as the selected option tag. You can also supply an array of countries as priority_countries, so that they will be listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
      #
      def iso_options_for_select(selected = nil, priority_countries = nil)
        countries_for_select = ISO::Countries.country_code_by_name_lookup.to_a

        country_options = ""

        if priority_countries
          priority_countries.map! { |code| [ISO::Countries.get_country(code), code] }

          country_options += options_for_select(priority_countries, selected)
          country_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"

          countries_for_select = countries_for_select.reject { |c| priority_countries.include?( c ) }
        end

        country_options += options_for_select(countries_for_select.sort, selected)

        return country_options.html_safe
      end
    end

    class InstanceTag
      def to_country_select_tag(priority_countries, options, html_options) #:nodoc:
        if html_options.has_key?(:class)
          html_options[:class] = html_options[:class] + " country"
        else
          html_options[:class] = "country"
        end
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            iso_options_for_select(value, priority_countries),
            options, value
          ), html_options
        )
      end
    end

    class FormBuilder
      def country_select(method, priority_countries = nil, options = {}, html_options = {})
        @template.country_select(@object_name, method, priority_countries, options.merge(:object => @object), html_options)
      end
    end
  end
end
