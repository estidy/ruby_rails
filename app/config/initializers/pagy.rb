# Better user experience handled automatically
require 'pagy/extras/bootstrap'
require 'pagy/extras/overflow'

Pagy::DEFAULT[:items] = 12        # items per page
Pagy::DEFAULT[:size]  = [1,4,4,1] # nav bar links
Pagy::DEFAULT[:overflow] = :last_page
Pagy::DEFAULT[:overflow] = :empty_page