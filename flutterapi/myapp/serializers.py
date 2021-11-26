from rest_framework import serializers
from .models import Todolist

class TodolistSerializers(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Todolist
        fields = ('id','title','detail') #'__all__'
    