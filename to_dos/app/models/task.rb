class Task < ActiveRecord::Base

# # Fíjate en la línea anterior como este modelo está heredando de la clase
# # ActiveRecord::Base
# # Que tanto código te regala ActiveRecord

validates :name, presence: true, uniqueness: true

end