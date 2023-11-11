import re

class Registration():
    def __init__(self, name, email, password):
        self.name = name
        self.email = email
        self.password = password

    def check_details(self):
        check = re.findall("@sggscc.ac.in$", self.email)
        if not check:
            return False
        return True
    
    def check_password(self):
        if len(self.password) >= 8:
            return True
        return False
    
    def store_password(self):
        pass
          