#Wave View

This app is for iOS, for drawing the wave shape

![image](http://www.liuhedao.com/t/5/1357137142x-1376440253.png)

##Usage

1）copy **WaveView.h** and **WaveView.m** to your project

2）add a UIView in Xib, change the Class to Wave View, make connection to your viewController

    @property (weak, nonatomic) IBOutlet WaveView *waveViewDefault;

3) init the WaveView

    [self.waveViewDefault setWaveType:kWaveTypeDefault MaxValue:0 MinValue:-160];
    
4) use this method where can get the changing value, to start waving

    [self.waveViewDefault startWavingWithValue:changingValue];

