#!/bin/bash

SRCDIR="/home/student/Documents/my_work/"
DESTDIR="/home/student/Backups/"
FILENAME=backup1-$(date +%-Y%-m%-d)-$(date +%-T).tgz 
tar --create --gzip --file=$DESTDIR$FILENAME $SRCDIR