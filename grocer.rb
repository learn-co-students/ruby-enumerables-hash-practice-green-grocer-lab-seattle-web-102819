def consolidate_cart(cart)
  clean_cart = {}
  cart.each do |item_hash|
    item_hash.each do |item, attributes|
      clean_cart[item] ||=attributes
      clean_cart[item][:count] ? clean_cart[item][:count] +=1 : clean_cart[item][:count] = 1
    end
  end
  clean_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash| #hash of each item
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

def checkout(cart, coupons)
  total = 0
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  clearance_cart.each do |item, attribute_hash|
    total += (attribute_hash[:price] * attribute_hash[:count])
  end
  if total > 100
    total = (total * 0.9)
  end
  total
end
