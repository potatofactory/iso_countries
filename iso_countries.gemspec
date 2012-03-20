# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'iso_countries'
  s.version = '0.2'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Jeremy Weiskotten']
  s.email = 'jeremy@weiskotten.com'
  s.extra_rdoc_files = ['README.rdoc']
  s.files = ['README.rdoc', 'MIT-LICENSE', 'Rakefile', 'init.rb', 'lib/iso', 'lib/iso/countries', 'lib/iso/countries/country_field.rb', 'lib/iso/countries/form_helpers.rb', 'lib/iso_countries.rb', 'test/iso_countries_test.rb']
  s.homepage = 'http://github.com/jeremyw/iso_countries'
  s.rdoc_options = ['--line-numbers', '--inline-source']
  s.require_paths = ['lib']
  s.requirements = ['iso_country_codes']
  s.summary = 'Country selector with ISO codes.'

  s.add_dependency 'actionpack', '>= 2.3.8'
  s.add_dependency 'activesupport', '>= 2.3.8'
  s.add_dependency 'iso_country_codes', '~> 0.2.0'
end
