require 'spec_helper'

describe Whois do

  class Whois::Parsers::ParserTest < Whois::Parsers::Base
    property_supported :available? do
      eval(content_for_scanner)
    end
    property_supported :registered? do
      !available?
    end
  end

  describe ".available?" do
    it "queries the domain and returns true" do
      with_definitions do
        Whois::Server.define(:tld, ".test", "parser.test")
        expect_any_instance_of(Whois::Server::Adapters::Standard).to receive(:query_the_socket).with("example.test", "parser.test").and_return("1 == 1")

        expect(Whois.available?("example.test")).to be_truthy
      end
    end

    it "queries the domain and returns false" do
      with_definitions do
        Whois::Server.define(:tld, ".test", "parser.test")
        expect_any_instance_of(Whois::Server::Adapters::Standard).to receive(:query_the_socket).with("example.test", "parser.test").and_return("1 == 2")

        expect(Whois.available?("example.test")).to be_falsey
      end
    end

    it "returns nil when missing parser" do
      with_definitions do
        Whois::Server.define(:tld, ".test", "missing.parser.test")
        expect_any_instance_of(Whois::Server::Adapters::Standard).to receive(:query_the_socket).and_return("1 == 2")
        expect(Whois).to receive(:warn)

        expect(Whois.available?("example.test")).to be_nil
      end
    end
  end

  describe ".registered?" do
    it "queries the domain and returns false" do
      with_definitions do
        Whois::Server.define(:tld, ".test", "parser.test")
        expect_any_instance_of(Whois::Server::Adapters::Standard).to receive(:query_the_socket).with("example.test", "parser.test").and_return("1 == 1")

        expect(Whois.registered?("example.test")).to be_falsey
      end
    end

    it "queries the domain and returns true" do
      with_definitions do
        Whois::Server.define(:tld, ".test", "parser.test")
        expect_any_instance_of(Whois::Server::Adapters::Standard).to receive(:query_the_socket).with("example.test", "parser.test").and_return("1 == 2")

        expect(Whois.registered?("example.test")).to be_truthy
      end
    end

    it "returns nil when missing parser" do
      with_definitions do
        Whois::Server.define(:tld, ".test", "missing.parser.test")
        expect_any_instance_of(Whois::Server::Adapters::Standard).to receive(:query_the_socket).and_return("1 == 2")
        expect(Whois).to receive(:warn)

        expect(Whois.registered?("example.test")).to be_nil
      end
    end
  end

end
