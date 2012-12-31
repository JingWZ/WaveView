//
//  ViewController.h
//  WaveViewDemo
//
//  Created by apple on 12-12-30.
//  Copyright (c) 2012年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "WaveView.h"


@interface ViewController : UIViewController{
    AVAudioRecorder *mRecorder;
    NSTimer *timer;
    float val;
}

@property (weak, nonatomic) IBOutlet WaveView *waveViewMirror;
@property (weak, nonatomic) IBOutlet WaveView *waveViewDefault;


- (IBAction)startWaving:(id)sender;
- (IBAction)stopWaving:(id)sender;

@end
