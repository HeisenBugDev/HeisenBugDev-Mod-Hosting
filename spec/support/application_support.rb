# Takes a hash and switches out a value
#
# @example
#   replace_hash_value({:test => 17, :hai => 'sdjkf'},
#                      {:test => 3})
#     #=> {:test => 3, :hai => 'sdjkf'}
#
# @param hash [Hash] The hash to modify
# @param change [Hash] The value you would like to change.
#
# @return A hash with that element changed.
def replace_hash_value(hash, change)
  change.each do |key, value|
    hash[key] = value
  end
end
