# encoding: utf-8

# This file is autogenerated. Do not edit it manually.
# If you want change the content of this file, edit
#
#   /spec/fixtures/responses/whois.registrypro.pro/status_reserved.expected
#
# and regenerate the tests with the following rake task
#
#   $ rake spec:generate
#

require 'spec_helper'
require 'whois/parsers/whois.registrypro.pro.rb'

describe Whois::Parsers::WhoisRegistryproPro, "status_reserved.expected" do

  subject do
    file = fixture("responses", "whois.registrypro.pro/status_reserved.txt")
    part = Whois::Record::Part.new(body: File.read(file))
    described_class.new(part)
  end

  describe "#status" do
    it do
      expect(subject.status).to eq(:reserved)
    end
  end
  describe "#reserved?" do
    it do
      expect(subject.reserved?).to eq(true)
    end
  end
end
