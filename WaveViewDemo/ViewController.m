//
//  ViewController.m
//  WaveViewDemo
//
//  Created by apple on 12-12-30.
//  Copyright (c) 2012年 jing. All rights reserved.
//

#import "ViewController.h"

#define kTimeInterval 0.1

@interface ViewController ()

@end

@implementation ViewController
@synthesize waveViewMirror;
@synthesize waveViewDefault;

#pragma mark - action

- (IBAction)startWaving:(id)sender {
    [mRecorder record];
    if (![timer isValid]) {
        timer=[NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(waveViewUpdate) userInfo:nil repeats:YES];
    }
    
}

- (IBAction)stopWaving:(id)sender {
    [mRecorder stop];
    [timer invalidate];
}

- (void)waveViewUpdate{
    
    [mRecorder updateMeters];
    float volume=[mRecorder averagePowerForChannel:0];
    
    [self.waveViewDefault startWavingWithValue:volume];
    [waveViewMirror startWavingWithValue:volume];
    
}

#pragma mark - set Wave View

- (void)initWaveViewDefault{
    [self.waveViewDefault setWaveType:kWaveTypeDefault MaxValue:0 MinValue:-160];
    [self.waveViewDefault setBanchmarkHeight:20];
}

- (void)initWaveViewMirror{
    [waveViewMirror setWaveType:kWaveTypeMirror MaxValue:0 MinValue:-160];
    [self.waveViewMirror setZeroPointValue:-55];
}

- (void)initAudioRecorder{
    NSArray *directories=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[directories objectAtIndex:0];
    NSString *recordPath=[documentPath stringByAppendingPathComponent:@"record.m4a"];
    NSURL *recordURL=[NSURL fileURLWithPath:recordPath];
    
    NSDictionary *setting=[NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
                           [NSNumber numberWithFloat:44100.0],AVSampleRateKey,
                           [NSNumber numberWithInt:1],AVNumberOfChannelsKey, nil];

    mRecorder=[[AVAudioRecorder alloc] initWithURL:recordURL settings:setting error:nil];
    [mRecorder setMeteringEnabled:YES];
    [mRecorder prepareToRecord];
}

- (void)viewDidAppear:(BOOL)animated{
    [self initAudioRecorder];
    [self initWaveViewDefault];
    [self initWaveViewMirror];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    
    mRecorder=nil;
    timer=nil;
    [self setWaveViewDefault:nil];
    [self setWaveViewMirror:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
