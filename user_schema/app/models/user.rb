class User < ActiveRecord::Base
# Implementa los métodos y validaciones de tu modelo aquí. 
 
# Crea un método llamado name que regrese el nombre completo del usuario.
  
  def name
    @first_name + @last_name
  end

# Crea un método llamado age que regrese la edad en años del usuario. 

  def age
    now.year - @birthday.year
  end
# La dirección de email deberá contener una @ y al menos un . , con al menos un caracter antes de la @, un caracter entre la @ y el primer . y al menos dos caracteres después del . final.
# Dos usuarios no deberán tener el mismo email, este debe de ser único.
# Los usuarios deberán de ser mayores de edad.


end
