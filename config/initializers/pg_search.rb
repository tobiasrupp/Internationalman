# PgSearch.multisearch_options = {
#   :using => { :tsearch => { :prefix => true, :dictionary => "english", :any_word => true }},
#     associated_against: {categories: :name}
# }

PgSearch.multisearch_options = {
  :using => {
    :tsearch => {
    	# :prefix => true,
      # :dictionary => "english",
      :any_word => true 
    },
  },
  # ignoring: :accents
}
