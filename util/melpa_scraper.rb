require 'bundler/setup'

require "json"
require "net/http"
require "set"
require "pry"
require "oj"
require 'concurrent'

indent_level = !ENV['DEBUG'].nil? ? 2 : -1

Oj.default_options = { mode: :object, indent: indent_level, symbol_keys: false }

BASE_URL="http://melpa.org"

def fetch_json_document(relative_url)
  uri = URI(BASE_URL + relative_url)
  Concurrent::Future.execute do
    document = Net::HTTP.get uri
    Oj.load(document).freeze
  end
end

archive_data = fetch_json_document("/archive.json")
recipes_data = fetch_json_document("/recipes.json")
dl_counts_data = fetch_json_document("/download_counts.json")
build_status = fetch_json_document("/build-status.json")


result = Concurrent::dataflow(archive_data, recipes_data, dl_counts_data) do |archive, recipes, dl_counts|

  documents = [archive, recipes]

  keys = [archive, recipes, dl_counts].map {|h| h.keys.to_set }.reduce(&:union)

  list = keys.reduce({}) do |merged, key|
    begin
      merged[key] = {}
      documents.each do |d|
        next if d[key].nil?
        merged[key].merge! d[key]
      end
      merged
    rescue => e
      binding.pry
    end
  end
end

File.open "out.json", "w+" do |f|
  f.write Oj.dump(result.value)
end
