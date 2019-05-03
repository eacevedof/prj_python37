import re

from django.core.exceptions import ValidationError
from django.db import models
from django.utils.translation import gettext_lazy as _


class TheappBooleanField(models.BooleanField):

    def __init__(self, *args, **kwargs):
        pr("__init__","TheappBooleanField 1")
        kwargs['max_length'] = 3
        super().__init__(*args, **kwargs)

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
    def get_db_prep_value(self, value, connection, prepared=False):
        pr("get_db_prep_value","TheappBooleanField 6")
        value = super().get_db_prep_value(value, connection, prepared)
        if value is not None:
            return connection.Database.Binary(value)
        return value              

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
    
