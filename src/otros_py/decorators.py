PASSWORD = "agua"

def password_required(func):
    def envoltorio():
        password = input("Cual es tu contrasena? ")
        if password == PASSWORD:
            #se le pasas needs_password. Imprime la contraseña es correcta
            return func()
        else:
            print("La contraseña no es correcta.")

    # devuelve envoltorio()
    return envoltorio
#def password_required

@password_required
def needs_password():
    print("La contraseña es correcta")
#def needs_password()

def upper(func):
    def envoltorio(*args, **kwargs):
        result = func(*args, **kwargs)
        #print(result)
        return result.upper()
    return envoltorio


@upper
def say_my_name(name):
    #print("Hola, {}".format(name))
    return "Hola, {}".format(name)


if __name__ == "__main__":
    #solo se ejecutara needs_password si su decoradora la ejecuta
    # needs_password()
    print(say_my_name("David"))