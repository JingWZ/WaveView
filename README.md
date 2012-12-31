#Wave View

This app is for iOS, for drawing the wave shape

![image](http://img.u.115.com/thumb/0/0C/0C/00C0CBB9D910DD7FBFF15122312DEBD1FB22A811_800_800?s=C_zQknDCnmOXeUgM7Yg-dQ&t=1356940800&sync=1)

##Usage

1) copy **WaveView.h** and **WaveView.m** to your project

2）add a UIView in Xib, change the Class to Wave View, make connection to your viewController

    @property (weak, nonatomic) IBOutlet WaveView *waveViewDefault;

3) init the WaveView

    [self.waveViewDefault setWaveType:kWaveTypeDefault MaxValue:0 MinValue:-160];
    
4) use this method where can get the changing value, to start waving

    [self.waveViewDefault startWavingWithValue:changingValue];

