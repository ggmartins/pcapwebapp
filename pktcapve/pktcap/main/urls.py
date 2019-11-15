from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('status', views.status, name='status'),
    path('start', views.start, name='start'),
    path('stop', views.stop, name='stop'),
    path('scan', views.scan, name='scan'),
]
