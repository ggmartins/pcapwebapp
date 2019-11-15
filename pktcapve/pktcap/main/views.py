from django.shortcuts import render
from django.http import HttpResponse
from subprocess import Popen, PIPE
import json

def index(request):
    #return HttpResponse("Hello, world. You're at the polls index.")
    return render(request, "index.html", {"status": "stopped" , "files": None })

def status(request):
    r = "Error: Unknown."
    p = Popen("./pcapp.sh status", shell=True, stdout=PIPE, stderr=PIPE)
    p.wait()
    res = p.communicate() 
    if p.returncode == 0:
      r=res[0].decode("utf-8").strip(" \t\n")
    else:
      r=res[1].decode("utf-8").strip(" \t\n")+" - "+res[0].decode("utf-8").strip(" \t\n")
    #print('result:' + str(p.returncode) +" ["+ r +"]")
    return HttpResponse(r)

def start(request):
    r="WARNING: Unknown internal error."
    p = Popen("./pcapp.sh start", shell=True, stdout=PIPE, stderr=PIPE)
    p.wait()
    res = p.communicate()
    if p.returncode == 0:
      r=res[0].decode("utf-8").strip(" \t\n")
    return HttpResponse(r)

def stop(request):
    r="WARNING: Unknown internal error."
    p = Popen("./pcapp.sh stop", shell=True, stdout=PIPE, stderr=PIPE)
    p.wait()
    res = p.communicate()
    if p.returncode == 0:
      r=res[0].decode("utf-8").strip(" \t\n")
    return HttpResponse(r)


def scan(request):
    p = Popen("./pcapp.sh scan", shell=True, stdout=PIPE, stderr=PIPE)
    p.wait()
    res = p.communicate() 
    #if p.returncode == 0:
    r=res[0].decode("utf-8").split("\n")
    #else:
    #  r=res[1].decode("utf-8").strip(" \t\n")+" - "+res[0].decode("utf-8").strip(" \t\n")
    l = []
    for i in r:
        l.append(i.strip(" \n"))

    #print('result:' + str(p.returncode) +" ["+ r +"]")
    return HttpResponse(json.dumps(l));

# Create your views here.

