//
//  WaveView.h
//  RecordAudio
//
//  Created by apple on 12-12-27.
//  Copyright (c) 2012年 apple. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum {
    
    kWaveTypeDefault = 0,
    kWaveTypeMirror = 1
    
} WaveType ;

@interface WaveView : UIView

/*init*/
//max and min is of the VALUE that waves
- (WaveView *)initWaveWithType:(WaveType)type Frame:(CGRect)frame MaxValue:(CGFloat)max MinValue:(CGFloat)min;
//use it if already set the frame or built the view in Xib
- (WaveView *)setWaveType:(WaveType)type MaxValue:(CGFloat)max MinValue:(CGFloat)min;


/*fill the changing value*/
- (void)startWavingWithValue:(CGFloat)value;


/*settings*/
//wave range in y axis，default is established view's height in WaveTypeDefault and height/2 in WaveTypeMirror
- (void)setWaveRange:(CGFloat)range;
//interval in x axis, default is 1.0
- (void)setXInterval:(CGFloat)interval;
//wave line width, default is 1.0, only available in WaveTypeDefault
- (void)setWaveLineWidth:(CGFloat)width;
//wave line color, default is red, only available in WaveTypeDefault
- (void)setWaveLineColor:(CGColorRef)color;
//banchmark, increases in values from bottom to top, default is view's height/2, only available in WaveTypeDefault
- (void)setBanchmarkHeight:(CGFloat)height;
//a boolean value that determines whether the wave is filling, default is NO, only available in WaveTypeDefault
- (void)setFilling:(BOOL)filling;
//filling color, default is blue
- (void)setFillingColor:(CGColorRef)color;
//only available in WaveTypeMirror, the update value under this value will be ignored, to filter noise
- (void)setZeroPointValue:(CGFloat)value;
- (void)setZeroPointLineWidth:(CGFloat)width;

@end
