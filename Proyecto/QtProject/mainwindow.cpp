/*
 * DSP Example is part of the DSP Lecture at TEC-Costa Rica
 * Copyright (C) 2010  Pablo Alvarado
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * \file   mainwindow.cpp
 *         Implements the equalizer H(w) computation
 * \author Pablo Alvarado
 * \date   2010.12.12
 *
 * $Id: equalizer.cpp $
 */


#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "jack.h"
#include "constants.h"
#include <string>
#include <iostream>

#undef _DSP_DEBUG
#define _DSP_DEBUG

#ifdef _DSP_DEBUG
#define _debug(x) std::cerr << x
#include <iostream>
#else
#define _debug(x)
#endif


/**
 * Precision used by trimming
 */
const float MainWindow::Epsilon = 0.001;


MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow),
    verbose_(false),
    dspChanged_(true)
{
    ui->setupUi(this);
    /*
     * Set up a timer 4 times in a second to check if the user
     * changed the equalizer values, and if so, then create a new
     * filter response
     */
    timer_ = new QTimer(this);
    connect(timer_, SIGNAL(timeout()), this, SLOT(update()));
    timer_->start(250);

    dsp_ = new dspSystem;
    jack::init(dsp_);

    // parse some command line arguments
    QStringList argv(QCoreApplication::arguments());

    QStringList::const_iterator it(argv.begin());
    while(it!=argv.end()) {
      if ((*it)=="-v" || (*it)=="--verbose") {
        verbose_=true;
      } else if ((*it).indexOf(".wav",0,Qt::CaseInsensitive)>0) {
        //ui->fileEdit->setText(*it);
        std::string tmp(qPrintable(*it));
        jack::playAlso(tmp.c_str());
      }
      ++it;
    }

}


MainWindow::~MainWindow()
{
    jack::close();
    delete timer_;
    delete ui;
    delete dsp_;
}

void MainWindow::update() {
    if(dspChanged_){
        _debug("Updating" << std::endl);

        dspChanged_=false;
    }
    
}


void MainWindow::on_volumeSlider_valueChanged(int value){
    if (!dspChanged_){
        dspChanged_=true;
    }
    dsp_->updateVolume(value);
}



void MainWindow::on_button1_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[0], constants::upperFrequencies[0]);
}

void MainWindow::on_button1_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_button2_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[0], constants::upperFrequencies[1]);
}

void MainWindow::on_button2_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_button3_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[0], constants::upperFrequencies[2]);
}

void MainWindow::on_button3_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_buttonA_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[0], constants::upperFrequencies[3]);
}

void MainWindow::on_buttonA_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_button4_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[1], constants::upperFrequencies[0]);
}

void MainWindow::on_button4_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_button5_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[1], constants::upperFrequencies[1]);
}

void MainWindow::on_button5_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_button6_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[1], constants::upperFrequencies[2]);
}

void MainWindow::on_button6_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_buttonB_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[1], constants::upperFrequencies[3]);
}

void MainWindow::on_buttonB_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_button7_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[2], constants::upperFrequencies[0]);
}

void MainWindow::on_button7_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_button8_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[2], constants::upperFrequencies[1]);
}

void MainWindow::on_button8_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_button9_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[2], constants::upperFrequencies[2]);
}

void MainWindow::on_button9_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_buttonC_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[2], constants::upperFrequencies[3]);
}

void MainWindow::on_buttonC_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_buttonS_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[3], constants::upperFrequencies[0]);
}

void MainWindow::on_buttonS_released(){
  dsp_->setToneActive(false);
}

void MainWindow::on_button0_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[3], constants::upperFrequencies[1]);
}

void MainWindow::on_button0_released(){
  dsp_->setToneActive(false); 
}

void MainWindow::on_buttonN_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[3], constants::upperFrequencies[2]);
}

void MainWindow::on_buttonN_released(){
  dsp_->setChainActive(true);
  dsp_->setUChain("0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789");
  dsp_->setChainFlank(true);
  dsp_->setPChain(0);
  // dsp_->setToneActive(false); // Comments as we need this to start playing the 
}

void MainWindow::on_buttonD_pressed(){
  dsp_->setToneActive(true);
  dsp_->setFrequencies(constants::sideFrequencies[3], constants::upperFrequencies[3]);
}

void MainWindow::on_buttonD_released(){
  dsp_->setToneActive(false);
}
