def consolidate_cart(cart)
 final_cart = {}
 cart.each do |element_hash|
   element_name = element_hash.keys[0]
if final_cart.has_key?(element_name)
  final_cart[element_name][:count] += 1
else final_cart[element_name] = {
  count: 1,
  price: element_hash[element_name][:price],
  clearance: element_hash[element_name][:clearance]
}
   end
  end
 final_cart
end
   
 #if cart[item][:count] >= coupon[:num] && !cart.has_key

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  item = coupon[:item]
  if cart.has_key?(item)
    if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
      cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
      cart[item][:count] -= coupon[:num]
    elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
      cart["#{item} W/COUPON"][:count] += coupon[:num]
      cart[item][:count] -= coupon[:num]
    end  
   end
  end
 cart
end

def apply_clearance(cart)
   cart.each do |item_name, stats|
     stats[:price] -= stats[:price] * 0.2 if stats[:clearance]
 end
 cart
end

def checkout(cart, coupons)
  hash_cart =consolidate_cart(cart)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)
  total = applied_clearance.reduce(0) { |acc, (key, value)|
  acc += value[:price] * value[:count]}
  total > 100 ? total * 0.9 : total
end
