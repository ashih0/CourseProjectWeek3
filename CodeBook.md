# Code Book

## Introduction

The raw data is based on:

    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Activity Types

The activity types in the study were:

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

See [this video](https://www.youtube.com/watch?v=XOEN9W05_4A) for an
example of the how the measurement apparatus was attached to the test
subject.


## Measurement Types

There are two main measurement types as described in `'UCI HAR Dataset/README.txt'`:

* Linear Acceleration

    Variables with "LinearAcceleration" in their name are taken from
    the Samsung Galaxy S II using its embedded accelerometer.  Linear
    acceleration for 3 axes were captured at a rate of 50 Hz and are
    indicated by "X", "Y", or "Z" in the variable name.

    This measurement is in standard gravity units "g".  To interpret
    this as physical units, multiply the value of the variable by 9.8
    m / s^2 .  However, most analyses of the data are likely only
    concerned with how the measurements relate to each other instead
    of any physical phenomenon outside the system.

* Angular Velocity

    Variables with "AngularVelocity" in their name are taken from
    Samsung Galaxy S II using its embedded gyroscope.  Angular
    velocity for 3 axes were captured at a rate of 50 Hz.

    These measurements are in units of radians / second.


## Signal Processing

The signal processing applied to the raw data from the accelerometers
and gyroscopes is described in `'UCI HAR Dataset/features_info.txt'`.

Raw signal data was filtered using a median filter and a 3rd order low
pass Butterworth filter with a corner frequency of 20 Hz to remove
noise.


## Gravity vs Body

The distinction between "Gravity" and "Body" signals is described in
`'UCI HAR Dataset/features_info.txt'`.

Body and Gravity acceleration signals were separated using another low
pass Butterworth filter with a corner frequency of 0.3 Hz.

This is indicated in the variable names containing "Body" and
"Gravity", respectively.


## Sliding Windows

The smoothing of data is described on the web page:

    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Fixed-width sliding windows of 2.56 sec and 50% overlap (128
readings/window) were used.

* Mean

   Mean of the measurement in the sliding window indicated by "Mean"
   in the variable name.

    In the original dataset, these values were indicated by including
    "-mean()" in the name.

* Standard Deviation

    Standard deviation of the measurement in the sliding window
    indicated by "StandardDeviation" in the variable name.

    In the original dataset, these values were indicated by including
    "-std()" in the name.


## Processing

Processing applied to the "raw" data is described in `'UCI HAR Dataset/features_info.txt'`.

* Magnitude

    "Magnitude" in the name indicates that is a euclidian norm over the
    corresponding "X", "Y", and "Z" measurements.

    In the original dataset, these variables were indicated by including
    "Mag" in the name.


* Derivative

    Variables with "Derivative" in the name were derived based in time
    based on the 50 Hz sampling frequency.

    These are available for both LinearAcceleration and AngularVelocity
    variables.

    In the original dataset, these variables were indicated by including
    "Jerk" in the name.


## Time and Frequency Domain

* TimeDomain

    Variable names beginning with "TimeDomain" are the original
    measurements taken at 50 Hz.

    In the original dataset, these variables were indicated by beginning
    with a lower case "t" in the name.

* FrequencyDomain

    A Fast Fourier Transform (FFT) was applied to some of the signals.

    In the original dataset, these variables were indicated by beginning
    with a lower case "f" in the name.

