require 'temple'
require 'tilt'
require 'treetop'

require 'tuml/lang'
require 'tuml/parser'
require 'tuml/filters'
require 'tuml/generator'
require 'tuml/engine'
require 'tuml/template'
require 'tuml/helpers'

Tilt.register 'tuml', Tuml::Template
