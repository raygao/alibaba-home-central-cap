# Add by Ray Gao to expand Spree model to support Geo-spatial

# See https://github.com/spree/spree/blob/e2bd38d4/core/lib/spree/permitted_attributes.rb
# http://www.rubycoloredglasses.com/2014/04/strong-parameters-with-spree-extensions/

Spree::PermittedAttributes.class_eval do
  @@address_attributes.push(:geo_lat, :geo_long)
end