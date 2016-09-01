require 'date'
require 'time'
class User < ActiveRecord::Base
# Implementa los métodos y validaciones de tu modelo aquí. 
# La dirección de email deberá contener una @ y al menos un . , con al menos un caracter antes de la @, 
#un caracter entre la @ y el primer .
# y al menos dos caracteres después del . final.
  validates :email, format: { with: /(\w)+@(\w)+.(\w){2,}/ , message: "Formato incorrecto"}
 # Dos usuarios no deberán tener el mismo email, este debe de ser único.
  validates :email, :uniqueness => true
 # Los usuarios deberán de ser mayores de edad.
  validate :valid_age?

  validate :valid_phone?

  def valid_age?
    if age < 18
      errors.add(:birthday, "mayor de edad")
    end
  end

  def valid_phone?
    if phone.gsub(/\D/,'').length < 10
      errors.add(:phone, "invalid_num")
    end
  end


# Crea un método llamado name que regrese el nombre completo del usuario.
  def name
    "#{first_name} #{last_name}"
  end

# Crea un método llamado age que regrese la edad en años del usuario. 

  def age
    now = Date.today
    now.year - birthday.year
  end

end
