class OrderDetail < ApplicationRecord
  enum making_status: { cannot_start: 0, waiting: 1, production: 2, completed: 3 }
  
end
