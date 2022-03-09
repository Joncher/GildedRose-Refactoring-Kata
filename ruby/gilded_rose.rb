require 'pry'
class GildedRose

  def initialize(items)
    @items = items
  end

  def lower_quality(item)
    if item.quality > 0
      item.quality = item.quality - 1
        if item.name.include?("Conjured") && item.quality > 1
          item.quality = item.quality - 1
        end
    end
  end

  def raise_quility(item)
    if item.quality < 50
      item.quality = item.quality + 1
       if item.name.include?("Conjured")
         item.quality = item.quality + 1
       end
    end
  end

  def update_quality()
    special_items = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Conjured Backstage passes to a TAFKAL80ETC concert","Conjured Aged Brie", "Sulfuras, Hand of Ragnaros","Conjured Sulfuras, Hand of Ragnaros"]
    backstage_pass = "Backstage passes to a TAFKAL80ETC concert"
    conjured_backstage_pass = "Conjured Backstage passes to a TAFKAL80ETC concert"
    sulfuras = "Sulfuras, Hand of Ragnaros"
    conjured_sulfuras = "Conjured Sulfuras, Hand of Ragnaros"

    @items.each do |item|
      unless special_items.include?(item.name)
        lower_quality(item)
      else
      raise_quility(item)
        if item.name == backstage_pass || item.name == conjured_backstage_pass
          if item.sell_in < 11
            raise_quility(item)
          end
          if item.sell_in < 6
            raise_quility(item)
          end
          if item.sell_in < 0
            item.quality = item.quality - item.quality
          end
        end
      end
    if item.name != sulfuras || item.name != conjured_sulfuras
      item.sell_in = item.sell_in - 1
    end
    if item.sell_in < 0
      lower_quality(item)    
    end
    end
  end
end


class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
