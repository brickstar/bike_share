class Cart
  attr_reader :contents

  def initialize(initial_content)
    @contents = initial_content || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_accessory(accessory_id)
    @contents[accessory_id.to_s] ||= 0
    @contents[accessory_id.to_s] += 1
  end

  def remove_accessory(accessory_id)
    @contents.delete(accessory_id.to_s)
  end

  def unpack_contents
    content_objs = contents.keys.map do |accessory_id|
      Accessory.find(accessory_id)
    end
    Hash[content_objs.zip(contents.values)]
  end

  def total
    unpack_contents.map do |accessory, quantity|
      accessory.price * quantity
    end.sum
  end

  def decrease_quantity(accessory_id)
    @contents[accessory_id.to_s] -= 1
  end
end
