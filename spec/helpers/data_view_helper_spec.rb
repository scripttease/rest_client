require "rails_helper"

RSpec.describe DataViewHelper do

  describe "#data_to_tags" do
    it "serializes a string" do
      string = "hello world"
      expect(helper.data_to_tags(string)).to eq string
    end

    it 'serialises a number' do
      number = 899
      expect(helper.data_to_tags(number)).to eq "899"
    end

    it 'serialises an empty array' do
      array = []
      tags = helper.data_to_tags(array)
      expect(tags).to eq content_tag(:ol)
      expect(tags.to_s).to eq "<ol></ol>"
    end

    it 'serialises an array' do
      array = ["hi"]
      tags = helper.data_to_tags(array)
      expected_tags = content_tag(:ol) do 
        content_tag(:li, "hi")
      end
      expect(tags).to eq(expected_tags)
    end

    it 'serialises an array of many elements' do
      array = ["hi", 666, "world"]
      tags = helper.data_to_tags(array)
      expected_tags = content_tag(:ol) do
        content_tag(:li, "hi") + content_tag(:li, "666") + content_tag(:li, "world")
      end
      expect(tags).to eq(expected_tags)
    end

    it 'serialises an empty hash' do
      hash = {}
      tags = helper.data_to_tags(hash)
      expect(tags).to eq content_tag(:ul)
      expect(tags.to_s).to eq "<ul></ul>"
    end


    it 'serialises a hash' do
      hash = {party: "unicorns"}
      tags = helper.data_to_tags(hash)
      expected_tags = content_tag(:ul) do
        content_tag(:li, content_tag(:b, "party: ") + "unicorns")
      end
      expect(expected_tags).to be_html_safe
      expect(tags).to eq(expected_tags)
    end

    it 'serialises a hash with multiple elems' do
      hash = {party: "unicorns", "elephants" => "big", "puppies" => 666}
      tags = helper.data_to_tags(hash)
      expected_tags = content_tag(:ul) do
        content_tag(:li, content_tag(:b, "party: ") + "unicorns") +
          content_tag(:li, content_tag(:b, "elephants: ") + "big") +
          content_tag(:li, content_tag(:b, "puppies: ") + "666")
      end
      expect(tags).to eq(expected_tags)
    end

    it 'serializes a nested arry' do
      array = ["stuff", ["and"]]
      tags = helper.data_to_tags(array)
      expected_tags = content_tag(:ol) do
        content_tag(:li, "stuff") + content_tag(:li) do
          content_tag(:ol) do
            content_tag(:li, "and")
          end
        end
      end
      expect(tags).to eq(expected_tags)
    end

    it 'serializes a nested nested arry' do
      array = ["stuff", ["and", ["things"]]]
      tags = helper.data_to_tags(array)
      expected_tags = content_tag(:ol) do
        content_tag(:li, "stuff") + content_tag(:li) do
          content_tag(:ol) do
            content_tag(:li, "and") + content_tag(:li) do
              content_tag(:ol) do
                content_tag(:li, "things")
              end
            end
          end
        end
      end
      expect(tags).to eq(expected_tags)
    end

    it 'serializes a nested hash' do
      hash = {"party" => {unicorns: "balloons"}}
      tags = helper.data_to_tags(hash)
      expected_tags = content_tag(:ul) do
        content_tag(:li) do
          content_tag(:b, "party: ") + content_tag(:ul) do
            content_tag(:li) do
              content_tag(:b, "unicorns: ") + "balloons"
            end
          end
        end
      end
      expect(tags).to eq(expected_tags)
    end

    it 'serializes an array nested in a hash' do
      hash = {"party" => {unicorns: [1]}}
      tags = helper.data_to_tags(hash)
      expected_tags = content_tag(:ul) do
        content_tag(:li) do
          content_tag(:b, "party: ") + content_tag(:ul) do
            content_tag(:li) do
              content_tag(:b, "unicorns: ") + content_tag(:ol) do
                content_tag(:li, "1")
              end
            end
          end
        end
      end
      expect(tags).to eq(expected_tags)
    end
  end
end
