from django.db import models

class TheappBooleanField(models.BooleanField):

    def from_db_value(self, value, expression, connection, context):
        if value is None:
            return value
        return int(0) # return 0/1

    def to_python(self, value):

        if value in ('Y', '1', True):
            return "1"
        if value in ('N', '0', False):
            return "0"

        raise ValueError("valueerror: {}".format(value))

    def get_prep_value(self, value):
        if value:
            return '1'
        else:
            return '0'

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

    