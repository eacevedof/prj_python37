import re

from django.core.exceptions import ValidationError
from django.db import models
from django.utils.translation import gettext_lazy as _


class TheappBooleanField(models.BooleanField):



    # debe devolver la tupla name, path, args, kwargs
    def deconstruct(self):
        pr("deconstruct","TheappBooleanField 2")
        name, path, args, kwargs = super().deconstruct()
        return name, path, args, kwargs   

    # from_db_value when the data is loaded from the database
    def from_db_value(self, value, expression, connection, context):
        pr("from_db_value","TheappBooleanField 3")
        if value is None:
            return value
        return int(0) # return 0/1

    # to_python() is called by deserialization and during the clean() method used from forms.
    def to_python(self, value):
        pr("to_python","TheappBooleanField 4")
        if value in ('Y', '1', True):
            return "1"
        if value in ('N', '0', False):
            return "0"

        raise ValueError("valueerror: {}".format(value))

    # get_prep_value() Converting Python objects to query values
    def get_prep_value(self, value):
        pr("get_prep_value","TheappBooleanField 5")
        if value:
            return '1'
        else:
            return '0'

    # get_db_prep_value() Converting query values to database values
"""    
    def get_db_prep_value(self, value, connection, prepared=False):
        pr("get_db_prep_value","TheappBooleanField 6")
        value = super().get_db_prep_value(value, connection, prepared)
        if value is not None:
            return connection.Database.Binary(value)
        return value              
"""

# class CurrencyField(models.IntegerField):
class TheappBooleanField2(models.BooleanField):    
# class TheappBooleanField2(models.CharField):
    description = "A field to save dollars as pennies (int) in db, but act like a float"

    def __init__(self, *args, **kwargs):
        kwargs['max_length'] = 1
        super(TheappBooleanField2, self).__init__(*args, **kwargs)

    def deconstruct(self):
        pr("deconstruct","TheappBooleanField2")

        name, path, args, kwargs = super().deconstruct()
        pr(name,"deconstruct.name")
        pr(path,"deconstruct.path")
        pr(args,"deconstruct.args")
        pr(kwargs,"deconstruct.kwargs")
        return name, path, args, kwargs   

    # def db_type(self, connection):
    #    pr("db_type","TheappBooleanField2")
    #    return "boolean"

   # from_db_value when the data is loaded from the database
    def from_db_value(self, value, expression, connection, context):
        pr("from_db_value","TheappBooleanField2")
        pr(value,"TheappBooleanField2.from_db_value.value calling self.to_python")
        # se recupera el valor de la bd, pero con esto no es suficiente, hay que pasarlo 
        # al formato que entiende django como booleano (True,False)      
        return self.to_python(value)

    # to_python() is called by deserialization and during the clean() method used from forms.
    # lo que se mostrará en el formulario
    def to_python(self, value):
        """
        Convert the input value into the expected Python data type, raising
        django.core.exceptions.ValidationError if the data can't be converted.
        Return the converted value. Subclasses should override this.
        """        
        pr(value,"TheappBooleanField2.to_python.value - value to form")
        if value is None:
            sc("to_python: return None")
            return None # muestra unknown
        elif value in (1,"1",'Y', 'y',True):
            sc("to_python: return True")
            return True
        elif value in (0,"0",'N', 'n', False):
            sc("to_python: return False")
            return False
        else:
            raise ValueError

    # get_prep_value() Converting Python objects to query values
    """
    def get_prep_value(self, value):
        # Perform preliminary non-db specific value checks and conversions
        pr(value,"TheappBooleanField2.get_prep_value.value - py obj to query value")
        if value is None:
            return None 
        elif value in (1,"1",'Y', 'y',True):
            return True
        else:
            return False
    """

    # get_db_prep_value() Converting query values to database values
    # lo que se guardará en la bd
    """    
    def get_db_prep_value(self, value, *args, **kwargs):
        pr("get_db_prep_value","TheappBooleanField2")
        pr(value,"TheappBooleanField2.get_db_prep_value.value query val to db val")
        if value is None:
            return value
        
        newvalue = value
        # newvalue = int(round(value * 33))
        # newvalue = False
        pr(newvalue,"TheappBooleanField2.get_db_prep_value.new-value")
        return newvalue

    def formfield(self, **kwargs):
        pr("formfield","TheappBooleanField2")
        pr(kwargs,"TheappBooleanField2.formfield.kwargs")        
        from django.forms import FloatField
        defaults = {'form_class': FloatField}
        defaults.update(kwargs)
        return super(TheappBooleanField2, self).formfield(**defaults)
    """


def parse_hand(hand_string):
    """Takes a string of cards and splits into a full hand."""
    p1 = re.compile('.{26}')
    p2 = re.compile('..')
    args = [p2.findall(x) for x in p1.findall(hand_string)]
    if len(args) != 4:
        raise ValidationError(_("Invalid input for a Hand instance"))
    return Hand(*args)

class HandField(models.Field):

    description = _("String (up to %(max_length)s)")

    def __init__(self, *args, **kwargs):
        kwargs['max_length'] = 104
        super().__init__(*args, **kwargs)

    def deconstruct(self):
        name, path, args, kwargs = super().deconstruct()
        # Only include kwarg if it's not the default
        # if self.separator != ",":
        #    kwargs['separator'] = self.separator
        return name, path, args, kwargs        

    # from_db_value when the data is loaded from the database
    def from_db_value(self, value, expression, connection):
        if value is None:
            return value
        return parse_hand(value)

    # to_python() is called by deserialization and during the clean() method used from forms.
    def to_python(self, value):
        if isinstance(value, Hand):
            return value

        if value is None:
            return value

        return parse_hand(value)   
    
    # get_prep_value() Converting Python objects to query values
    def get_prep_value(self, value):
        return ''.join([''.join(l) for l in (value.north,
                value.east, value.south, value.west)])

    # get_db_prep_value() Converting query values to database values
    def get_db_prep_value(self, value, connection, prepared=False):
        value = super().get_db_prep_value(value, connection, prepared)
        if value is not None:
            return connection.Database.Binary(value)
        return value    

    # your database storage is similar in type to some other field, so you can use that other field’s logic to create the right column.
    def get_internal_type(self):
        return 'CharField'        

    # To customize how the values are serialized by a serializer, you can override value_to_string().
    def value_to_string(self, obj):
        value = self.value_from_object(obj)
        return self.get_prep_value(value)
    
