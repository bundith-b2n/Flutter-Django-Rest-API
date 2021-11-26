from django.urls import path

# from django_api.flutterapi.myapp.models import Todolist
from .views import *
urlpatterns = [
    path('',home),
    path('api/all-todolist',all_todolist),
    path('api/post-todolist',post_todolist),
    path('api/put-todolist/<int:TID>',update_todolist),
    path('api/delete-todolist/<int:TID>',delete_todolist),
]
