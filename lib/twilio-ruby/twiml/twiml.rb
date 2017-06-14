require 'libxml'

module Twilio
  module TwiML
    class TwiMLError < StandardError
    end

    class TwiML
      # Generate getter/setter methods
      attr_accessor :name
      attr_accessor :indent

      def initialize(indent: false, **keyword_args)
        @name = self.class.name.split('::').last
        @indent = indent
        @value = nil
        @verbs = []
        @attrs = {}

        keyword_args.each do |key, val|
          if !(val.nil?)
            @attrs[TwiML.to_lower_camel_case(key)] = val
          end
        end
      end

      def self.to_lower_camel_case(symbol)
        # Symbols don't have the .split method, so convert to string first
        result = symbol.to_s.split('_').map(&:capitalize).join
        result[0].downcase + result[1..result.length]
      end

      def to_s()
        self.to_xml_str
      end

      def to_xml_str(xml_declaration = true)
        xml = self.xml.to_s(:indent => self.indent)

        return ('<?xml version="1.0" encoding="UTF-8"?>' + xml) if xml_declaration
        xml
      end

      def xml()
        # create XML element
        elem = LibXML::XML::Node.new(@name, @value)

        # set element attributes
        keys = @attrs.keys.sort
        keys.each do |key|
          value = @attrs[key]

          if (value.is_a?(TrueClass) || value.is_a?(FalseClass))
            elem[key] = value.to_s.downcase
          else
            elem[key] = value.to_s
          end
        end

        @verbs.each do |verb|
          elem << verb.xml
        end

        elem
      end

      def append(verb)
        if !(verb.is_a?(TwiML))
          raise TwiMLError.new "Only appending of TwiML is allowed"
        end

        @verbs << verb
        self
      end
    end
  end
end
