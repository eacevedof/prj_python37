# theapp/models.py
# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from utils import utils as u

class AbstractSysfields(models.Model):
  
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True, default=u.get_platform(),editable=False)
    insert_user = models.CharField(max_length=15, blank=True, null=True, default=u.get_session_user(),editable=False)
    insert_date = models.CharField(max_length=14, blank=True, null=True, default=u.get_now(),editable=False)
    update_platform = models.CharField(max_length=3, blank=True, null=True, default=u.get_platform(),editable=False)
    update_user = models.CharField(max_length=15, blank=True, null=True, default=u.get_session_user(),editable=False)
    update_date = models.CharField(max_length=14, blank=True, null=True, default=u.get_now(),editable=False)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True,default=u.get_cruhist())
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True,default="1")
    i = models.IntegerField(blank=True, null=True)

    class Meta:
        abstract = True



class AppArray(AbstractSysfields):
    
    id = models.AutoField(primary_key=True)
    type = models.CharField(max_length=15, blank=False, null=True)
    description = models.CharField(max_length=250, blank=False, null=True)
    order_by = models.IntegerField(default=100)

    code_cache = models.CharField(max_length=250, blank=True, null=True, default=u.get_uuid())
    code_erp = models.CharField(max_length=25, blank=True, null=True)
    module = models.CharField(max_length=25, blank=True, null=True)
    id_tosave = models.CharField(max_length=25, blank=True, null=True)
    

    class Meta:
        managed = False # indica si se borrara la tabla al ejecutar las migraciones
        db_table = 'app_array'

    # sobreescritura
    def save(self, *args, **kwargs):
        print("something")
        super(AppArray,self).save(*args,**kwargs)


class AppExam(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    code_erp = models.CharField(max_length=25, blank=True, null=True)
    description = models.CharField(max_length=200, blank=True, null=True)
    is_notificable = models.IntegerField(blank=True, null=True)
    is_shareable = models.PositiveIntegerField()
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_exam'


class AppExamsSentences(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    id_sentence = models.IntegerField()
    id_exam = models.IntegerField()
    is_notificable = models.IntegerField(blank=True, null=True)
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_exams_sentences'


class AppExamsUsers(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    id_user = models.IntegerField()
    id_exam = models.IntegerField()
    is_notificable = models.IntegerField(blank=True, null=True)
    is_owner = models.IntegerField(blank=True, null=True)
    is_read = models.IntegerField(blank=True, null=True)
    is_write = models.IntegerField(blank=True, null=True)
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_exams_users'


class AppExamsUsersEvalh(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    id_exam_user = models.IntegerField()
    eval_date = models.CharField(max_length=14, blank=True, null=True)
    is_finished = models.IntegerField(blank=True, null=True)
    is_timeup = models.IntegerField(blank=True, null=True)
    rate_percent = models.DecimalField(max_digits=8, decimal_places=3, blank=True, null=True)
    id_type = models.IntegerField(blank=True, null=True)
    owner_notes = models.CharField(max_length=250, blank=True, null=True)
    pupil_notes = models.CharField(max_length=250, blank=True, null=True)
    owner_rate = models.DecimalField(max_digits=8, decimal_places=3, blank=True, null=True)
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_exams_users_evalh'


class AppExamsUsersEvall(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    id_evalh = models.IntegerField()
    id_sentence = models.IntegerField()
    id_langfrom = models.IntegerField(blank=True, null=True)
    id_langto = models.IntegerField(blank=True, null=True)
    is_write = models.IntegerField(blank=True, null=True)
    is_listen = models.IntegerField(blank=True, null=True)
    is_image = models.IntegerField(blank=True, null=True)
    is_spoken = models.IntegerField(blank=True, null=True)
    i_result = models.IntegerField(blank=True, null=True)
    i_time = models.IntegerField(blank=True, null=True)
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_exams_users_evall'


class AppSentence(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    code_erp = models.CharField(max_length=25, blank=True, null=True)
    description = models.CharField(max_length=200, blank=True, null=True)
    text_orig = models.CharField(max_length=500, blank=True, null=True)
    path_audio = models.CharField(max_length=500, blank=True, null=True)
    url_resource = models.CharField(max_length=500, blank=True, null=True)
    id_language = models.IntegerField(blank=True, null=True)
    is_notificable = models.IntegerField(blank=True, null=True)
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_sentence'


class AppSentenceImages(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    code_erp = models.CharField(max_length=25, blank=True, null=True)
    description = models.CharField(max_length=200, blank=True, null=True)
    id_sentence = models.IntegerField()
    path_local = models.CharField(max_length=500, blank=True, null=True)
    url_resource = models.CharField(max_length=500, blank=True, null=True)
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_sentence_images'


class AppSentenceTags(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    id_sentence = models.IntegerField()
    id_tag = models.IntegerField()
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_sentence_tags'


class AppSentenceTimes(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    id_sentence = models.IntegerField()
    date_checked = models.CharField(max_length=14, blank=True, null=True)
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_sentence_times'


class AppSentenceTr(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    code_erp = models.CharField(max_length=25, blank=True, null=True)
    description = models.CharField(max_length=200, blank=True, null=True)
    text_tr = models.CharField(max_length=500, blank=True, null=True)
    id_language = models.IntegerField(blank=True, null=True)
    id_sentence = models.IntegerField(blank=True, null=True)
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_sentence_tr'


class AppSentencesUsers(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    id_user = models.IntegerField()
    id_sentence = models.IntegerField()
    is_notificable = models.IntegerField(blank=True, null=True)
    is_owner = models.IntegerField(blank=True, null=True)
    is_read = models.IntegerField(blank=True, null=True)
    is_write = models.IntegerField(blank=True, null=True)
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'app_sentences_users'


class AppTag(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    id_type = models.IntegerField(blank=True, null=True)
    description = models.CharField(max_length=50, blank=True, null=True)
    slug = models.CharField(max_length=100, blank=True, null=True)
    order_by = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'app_tag'


class BaseLanguage(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    code_erp = models.CharField(max_length=25, blank=True, null=True)
    id_tosave = models.CharField(max_length=25, blank=True, null=True)
    description = models.CharField(max_length=250, blank=True, null=True)
    code_iso = models.CharField(max_length=10, blank=True, null=True)
    order_by = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'base_language'


class BaseLanguageLang(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    id_source = models.IntegerField(blank=True, null=True)
    id_language = models.IntegerField(blank=True, null=True)
    description = models.CharField(max_length=250, blank=True, null=True)
    order_by = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'base_language_lang'


class BaseUser(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    code_erp = models.CharField(max_length=25, blank=True, null=True)
    description = models.CharField(max_length=200, blank=True, null=True)
    first_name = models.CharField(max_length=100, blank=True, null=True)
    last_name = models.CharField(max_length=100, blank=True, null=True)
    email = models.CharField(max_length=50, blank=True, null=True)
    bo_login = models.CharField(max_length=100, blank=True, null=True)
    bo_password = models.CharField(max_length=250, blank=True, null=True)
    md_login = models.CharField(max_length=100, blank=True, null=True)
    md_password = models.CharField(max_length=250, blank=True, null=True)
    language = models.CharField(max_length=50, blank=True, null=True)
    id_language = models.IntegerField(blank=True, null=True)
    id_start_module = models.IntegerField(blank=True, null=True)
    path_picture = models.CharField(max_length=100, blank=True, null=True)
    id_profile = models.IntegerField(blank=True, null=True)
    code_type = models.CharField(max_length=25, blank=True, null=True)
    bo_tokenreset = models.CharField(max_length=250, blank=True, null=True)
    md_tokenreset = models.CharField(max_length=250, blank=True, null=True)
    log_attempts = models.IntegerField(blank=True, null=True)
    rating = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'base_user'


class BaseUserArray(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    code_erp = models.CharField(max_length=25, blank=True, null=True)
    type = models.CharField(max_length=15, blank=True, null=True)
    id_tosave = models.CharField(max_length=25, blank=True, null=True)
    description = models.CharField(max_length=250, blank=True, null=True)
    order_by = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'base_user_array'


class Template(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    code_erp = models.CharField(max_length=25, blank=True, null=True)
    description = models.CharField(max_length=200, blank=True, null=True)
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = '_template'


class TemplateArray(models.Model):
    processflag = models.CharField(max_length=5, blank=True, null=True)
    insert_platform = models.CharField(max_length=3, blank=True, null=True)
    insert_user = models.CharField(max_length=15, blank=True, null=True)
    insert_date = models.CharField(max_length=14, blank=True, null=True)
    update_platform = models.CharField(max_length=3, blank=True, null=True)
    update_user = models.CharField(max_length=15, blank=True, null=True)
    update_date = models.CharField(max_length=14, blank=True, null=True)
    delete_platform = models.CharField(max_length=3, blank=True, null=True)
    delete_user = models.CharField(max_length=15, blank=True, null=True)
    delete_date = models.CharField(max_length=14, blank=True, null=True)
    cru_csvnote = models.CharField(max_length=500, blank=True, null=True)
    is_erpsent = models.CharField(max_length=3, blank=True, null=True)
    is_enabled = models.CharField(max_length=3, blank=True, null=True)
    i = models.IntegerField(blank=True, null=True)
    code_erp = models.CharField(max_length=25, blank=True, null=True)
    type = models.CharField(max_length=15, blank=True, null=True)
    id_tosave = models.CharField(max_length=25, blank=True, null=True)
    description = models.CharField(max_length=250, blank=True, null=True)
    order_by = models.IntegerField()
    code_cache = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = '_template_array'
        
class VersionDb(models.Model):
    date = models.CharField(max_length=14, blank=True, null=True)
    version = models.CharField(max_length=15, blank=True, null=True)
    description = models.CharField(max_length=500, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'version_db'
