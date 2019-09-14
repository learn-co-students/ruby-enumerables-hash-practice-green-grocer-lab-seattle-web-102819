def consolidate_cart(cart)
  # code here
  new = {}
  cart.map do |item|
    name = item.keys[0]
    new[name] = item.values[0]
    if new[name][:count]
      new[name][:count] += 1
    else
      new[name][:count] = 1
    end
  end
  new
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    coupon_name = coupon[:item]
    coupon_num = coupon[:num]
    cart_item = cart[coupon_name]
    next if cart_item.nil? || cart_item[:count] < coupon_num
    cart_item[:count] -= coupon_num
    applied = cart["#{coupon_name} W/COUPON"]
    if applied
      applied[:count] += coupon_num
    else
      cart["#{coupon_name} W/COUPON"] = {
        price: coupon[:cost]/coupon_num,
        clearance: cart_item[:clearance],
        count: coupon_num
      }
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, val|
    clear = val[:clearance]
    if clear
      val[:price] = (val[:price] * 0.8).round(2)
    else
      next
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  discount_cart = apply_clearance(coupon_cart)
  
  final_price = 0
  
  discount_cart.each do |item, val|
    final_price += val[:count] * val[:price]
  end
  
  if final_price >= 100
    final_price = final_price * 0.9
  end
  final_price
end










