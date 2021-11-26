from django import http
from django.core.exceptions import ImproperlyConfigured
from django.shortcuts import render
from django.http import JsonResponse, response
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import serializers, status
from .serializers import TodolistSerializers
from .models import Todolist
# Create your views here.


#Get data
@api_view(['GET'])
def all_todolist(request):
    alltodolist = Todolist.objects.all() #select from model Todolist
    serializers = TodolistSerializers(alltodolist,many=True)
    return Response(serializers.data,status = status.HTTP_200_OK)

#Post data
@api_view(['POST'])
def post_todolist(request):
    if request.method == 'POST':
        serializers = TodolistSerializers(data = request.data)
        if serializers.is_valid():
            serializers.save()
            return Response(serializers.data,status = status.HTTP_201_CREATED)
        return Response(serializers.errors,status = status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_todolist(request,TID):
    todo = Todolist.objects.get(id =TID)
    if request.method == 'PUT':
        data = {}
        serializers = TodolistSerializers(todo,data=request.data)
        if serializers.is_valid():
            serializers.save()
            data['status'] = "Updated"
            return Response(data = data,status=status.HTTP_201_CREATED)
        return Response(serializers.errors,status= status.HTTP_404_NOT_FOUND)
    
@api_view(['DELETE'])
def delete_todolist(request,TID):
    todo = Todolist.objects.get(id = TID)
    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data['status'] = 'deleted'
            status_code = status.HTTP_200_OK
        else:
            data['status'] = 'false'
            status_code = status.HTTP_400_BAD_REQUEST
        return Response(data = data ,status=status_code)
            
    
data = [
    {
        "title":"What is computer?",
        "subtitle":"Computer is Electonic?",
        "image_url":"https://raw.githubusercontent.com/bundithdevER/BasicAPI/main/code2.jpg",
        "detail":"A computer is an electronic device that manipulates information, or data. It has the ability to store, retrieve, and process data. You may already know that you can use a computer to type documents, send email, play games, and browse the Web. You can also use it to edit or create spreadsheets, presentations, and even videos."
    },
    {
        "title":"What is Coding?",
        "subtitle":"Coding is writing?",
        "image_url":"https://raw.githubusercontent.com/bundithdevER/BasicAPI/main/code1.jpg",
        "detail":"In Creative Coding, students learn to design and create media using object-oriented programming as a medium for design, art, and games. ith a strong focus on creating interactive experiences for the web, the course moves past the sequential problem solving found in typical beginner programming and coding courses, so that designers and creatives can apply programming concepts to work in a variety of media, such as 2D graphics, animation, image and video processing."
    },
    {
        "title":"What is Python?",
        "subtitle":"Python is Programing Language?",
        "image_url":"https://raw.githubusercontent.com/bundithdevER/BasicAPI/main/cod3.jpg",
        "detail":"Companies are looking for data-driven decision makers, and this Career Path will teach you the skills you need to become just that. You'll learn to analyze data, communicate your findings, and even draw predictions using machine learning. Along the way, you'll build portfolio-worthy projects that will help you get job-ready."
    },
    {
        "title":"What is dart?",
        "subtitle":"Dart is Programing Language?",
        "image_url":"https://raw.githubusercontent.com/bundithdevER/BasicAPI/main/cod3.jpg",
        "detail":"A programming language optimized for building user interfaces with features such as sound null safety, the spread operator for expanding collections, and collection if for customizing UI for each platform"
    }
]

def home(request):
    return JsonResponse(data=data,safe=False)