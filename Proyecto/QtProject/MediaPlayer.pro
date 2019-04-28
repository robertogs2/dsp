#-------------------------------------------------
#
# Project created by QtCreator 2017-05-10T15:52:01
#
#-------------------------------------------------

QT       += core gui multimedia

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = MediaPlayer
TEMPLATE = app

LIBS += -lfftw3f -ljack -lsndfile -lGL

#INCLUDEPATH += /usr/include


SOURCES += main.cpp\
        mainwindow.cpp \
    jack.cpp \
    dspsystem.cpp \
    controlvolume.cpp \
    oscillator.cpp

HEADERS  += mainwindow.h \
            jack.h \
            processor.h \
            dspsystem.h \
    controlvolume.h \
    oscillator.h

FORMS    += mainwindow.ui
