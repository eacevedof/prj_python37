from django.db import models

class TheappBooleanField(models.BooleanField):

    def from_db_value(self, value, expression, connection, context):
        pr(value,"TheappBooleanField.from_db_value.value")
        if value is None:
            return value
        return int(value) # return 0/1

    def to_python(self, value):
        pr(value,"TheappBooleanField.to_python.value")
        if value in ('Y', '1', True):
            return "1"
        if value in ('N', '0', False):
            return "0"
        raise ValueError("valueerror: {}".format(value))

