require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "updates normal items quality correctly" do
      items = [Item.new("regular item", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 9
      expect(items[0].sell_in).to eq 9
    end

    it "once sell by date is passed quality degrades twice as fast" do
      items = [Item.new("regular item", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

    it "regular items quality is never negative" do
      items = [Item.new("regular item", 10, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "aged brie increases in value" do
      items = [Item.new("Aged Brie", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 11
    end

    it "quality of an item is never more that 50" do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "sulduras never decreases in quality " do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end

    it "backstage passes update correctly depending on sell by" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10),Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10),Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10),Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 11
      expect(items[1].quality).to eq 12
      expect(items[2].quality).to eq 13
      expect(items[3].quality).to eq 0
    end

    it "conjured items quality is never negative" do
      items = [Item.new("Conjured item", 10, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "conjured items degrade twice as fast" do
      items = [Item.new("Conjured foo", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

    it "conjured aged brie increase twice as fast" do
      items = [Item.new("Conjured Aged Brie", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
    end

    it "conjured sulfuras does not degrade" do
      items = [Item.new("Conjured Sulfuras, Hand of Ragnaros", 5, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end

    it "conjured backstage passes update correctly depending on sell by" do
      items = [Item.new("Conjured Backstage passes to a TAFKAL80ETC concert", 15, 10),Item.new("Conjured Backstage passes to a TAFKAL80ETC concert", 10, 10),Item.new("Conjured Backstage passes to a TAFKAL80ETC concert", 5, 10),Item.new("Conjured Backstage passes to a TAFKAL80ETC concert", -1, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
      expect(items[1].quality).to eq 14
      expect(items[2].quality).to eq 16
      expect(items[3].quality).to eq 0
    end

  end
end
