# encoding: utf-8
require 'spec_helper'
require "logstash/filters/csv"

describe LogStash::Filters::Csv do
  describe "Hello World Demo" do
    let(:config) do <<-CONFIG
      filter {
        csv {
          src_fields => ['call', 'response']
          dst_field => 'csv_output'
        }
      }
    CONFIG
    end

    sample("call" => "Marco", "response" => "polo") do
      expect(subject).to include("csv_output")
      expect(subject['csv_output']).to eq("Marco,polo")
    end
  end
end
