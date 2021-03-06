#--
# Ruby Whois
#
# An intelligent pure Ruby WHOIS client and parser.
#
# Copyright (c) 2009-2015 Simone Carletti <weppos@weppos.net>
#++


require_relative 'base'


module Whois
  module Scanners

    # Scanner for the whois.srs.net.nz record.
    class WhoisSrsNetNz < Base

      self.tokenizers += [
          :skip_empty_line,
          :skip_comment,
          :scan_keyvalue,
      ]


      tokenizer :skip_comment do
        @input.skip(/^%.*\n/)
      end

    end

  end
end
