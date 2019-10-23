def consolidate_cart(cart)
  cart = {}
  cart.each do |item_hash|
    item_hash.each do |item, attributes|
      cart[item] ||=attributes
      cart[item][:count] ? cart[item][:count] += 1 : cart[item][:count] = 1
    end
  end
  cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
    item=coupon_hash[:item]

    if cart[item] && cart[item][:count] >= coupon_hash[:num]
      if cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"][:count] += (1 * coupon_hash[:num])
      else
        cart["#{item} W/COUPON"] = {
          :price =>coupon_hash[:cost]/coupon_hash[:num],
          :clearance => cart[item][:clearance],
          :count => coupon_hash[:num]
          }
      end
      cart[item][:count] -= coupon_hash[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, attributes|
    if attributes[:clearance] == true
      attributes[:price] = (attributes[:price] *
      0.8).round(2)
    end
  end
cart
end

end

def checkout(cart, coupons)
    cart.each do |item, attributes|
    if attributes[:clearance] == true
      attributes[:price] = (attributes[:price] *
      0.8).round(2)
    end
  end
cart
end
