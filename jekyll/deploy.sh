#!/bin/sh

jekyll b && git add . && git commit -m "deploy to github" && git push
#rsync -avr --delete _site/ daisy:/home/httpd/html/student/fukai/
