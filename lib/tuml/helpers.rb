require 'cgi'
require 'json'
require 'sanitize'

module Tuml
  module Helpers

    # Prefix any theme variable with “Plaintext” to output the string with
    # HTML-tags stripped and appropriate characters converted to HTML-entities
    # (so they’re safe to include in HTML attributes, etc.).
    def self.plaintext text
      Sanitize.clean text
    end

    # Prefix any theme variable with “JS” to output a Javascript string
    # (wrapped in quotes).
    def self.js text
      text.to_json
    end

    # Prefix any theme variable with “JSPlaintext” to output a Javascript
    # string (wrapped in quotes) with HTML-tags stripped and appropriate
    # characters converted to HTML-entities.
    def self.jsplaintext text
      js plaintext(text)
    end

    # Prefix any theme variable with “ URLEncoded” to output a URL encoded
    # string.
    def self.urlencoded text
      CGI.escape text
    end

  end
end
