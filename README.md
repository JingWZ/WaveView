#Wave View

This app is for iOS, for drawing the wave shape

![image](http://img.u.115.com/thumb/0/0C/0C/00C0CBB9D910DD7FBFF15122312DEBD1FB22A811_800_800?s=C_zQknDCnmOXeUgM7Yg-dQ&t=1356940800&sync=1)

##Usage

1) add a UIView in Xib, change the Class to Wave View, make connection to .h

    @property (weak, nonatomic) IBOutlet WaveView *waveViewDefault;

2) init the WaveView

    [self.waveViewDefault setWaveType:kWaveTypeDefault MaxValue:0 MinValue:-160];
    
3) start waving

    [self.waveViewDefault startWavingWithValue:volume];

