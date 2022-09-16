
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/',include('blog.urls'))    # api diye slash dile blog urls e chole zabe

]
