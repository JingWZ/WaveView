//
//  WaveView.m
//  RecordAudio
//
//  Created by apple on 12-12-27.
//  Copyright (c) 2012年 apple. All rights reserved.
//

#import "WaveView.h"

#define kDefaultXInterval 1.0
#define kDefaultLineWidth 1.0

@interface WaveView (){
    
    NSInteger waveType;
    
    CGFloat maxValue;
    CGFloat minValue;
    
    CGFloat lastPointX;
    CGFloat lastPointY;
    CGFloat newPointX;
    CGFloat newPointY;
    
    CGFloat lineWidth;
    CGColorRef lineColor;
    CGFloat xInterval;
    CGFloat waveRange;
    CGFloat banchmark;
    
    CGFloat zeroPointValue;
    CGFloat zeroPointLineWidth;
    
    BOOL isFilling;
    CGColorRef fillingColor;
    
}

@end

@implementation WaveView

#pragma mark - init
- (WaveView *)initWaveWithType:(WaveType)type Frame:(CGRect)frame MaxValue:(CGFloat)max MinValue:(CGFloat)min{
    
    self=[super initWithFrame:frame];
    
    [self setWaveType:type MaxValue:max MinValue:min];
    
    return self;
}

- (WaveView *)setWaveType:(WaveType)type MaxValue:(CGFloat)max MinValue:(CGFloat)min{
    
    if (self) {
        
        maxValue=max;
        minValue=min;
        lastPointX=0;
        lastPointY=self.frame.size.height/2;
        newPointX=0;
        newPointY=self.frame.size.height/2;
        xInterval=kDefaultXInterval;
        
        lineWidth=1.0;
        lineColor=[[UIColor redColor] CGColor];
        isFilling=NO;
        fillingColor=[[UIColor blueColor] CGColor];
        zeroPointValue=min;
        zeroPointLineWidth=2;
        waveType=type;
        
        switch (waveType) {
            case 0:
                waveRange=self.frame.size.height;
                banchmark=self.frame.size.height/2;
                break;
            case 1:
                waveRange=self.frame.size.height/2;
                break;
        }
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


#pragma mark - draw

- (void)startWavingWithValue:(CGFloat)value{
    
    lastPointX=newPointX;
    lastPointY=newPointY;
    newPointX+=xInterval;
    
    //选择波形
    switch (waveType) {
        case 0:
            [self calculateDefaultWaveWithValue:value];
            break;
        case 1:
            [self calculateMirrorWaveWithValue:value];
            break;
    }
    //NSLog(@"(%f,%f),(%f,%f)",lastPointX,lastPointY,newPointX,newPointY);
    
    if (newPointX>self.bounds.size.width) {
        lastPointX=0;
        newPointX=xInterval;
        [self setNeedsDisplay];
    }else{
        [self setNeedsDisplayInRect:CGRectMake(lastPointX, 0, xInterval, self.bounds.size.height)];
    }
}

- (void)drawRect:(CGRect)rect
{
    switch (waveType) {
        case 0:
            [self drawDefaultWave];
            break;
        case 1:
            [self drawMirrorWave];
            break;
    }
}

- (void)drawDefaultWave{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    //画波形线
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, lastPointX, lastPointY);
    CGPathAddLineToPoint(path, NULL, newPointX, newPointY);
    
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor);
    CGContextStrokePath(context);
    CGPathRelease(path);
    
    
    //填充
    if (isFilling) {
        CGMutablePathRef path=CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, newPointX, newPointY);
        CGPathAddLineToPoint(path, NULL, newPointX, self.bounds.size.height);
        CGPathAddLineToPoint(path, NULL, lastPointX, self.bounds.size.height);
        CGPathAddLineToPoint(path, NULL, lastPointX, lastPointY);
        CGPathCloseSubpath(path);
        
        CGContextAddPath(context, path);
        CGContextSetFillColorWithColor(context, fillingColor);
        CGContextFillPath(context);
        CGPathRelease(path);
    }
}

- (void)drawMirrorWave{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, newPointX, newPointY);
    CGPathAddLineToPoint(path, NULL, newPointX, 2*waveRange-newPointY);
    CGPathAddLineToPoint(path, NULL, lastPointX, 2*waveRange-newPointY);
    CGPathAddLineToPoint(path, NULL, lastPointX, newPointY);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, fillingColor);
    CGContextFillPath(context);
    CGPathRelease(path);
    
}

- (void)calculateDefaultWaveWithValue:(CGFloat)value{
    
    newPointY=waveRange-waveRange*(value-minValue)/(maxValue-minValue);
    
}

- (void)calculateMirrorWaveWithValue:(CGFloat)value{
    if (value<zeroPointValue) {
        newPointY=waveRange-zeroPointLineWidth/2;
    }else{
    newPointY=waveRange-waveRange*(value-zeroPointValue)/(maxValue-zeroPointValue);
    }
}


#pragma mark - setting

- (void)setWaveRange:(CGFloat)range{
    waveRange=range;
}

- (void)setXInterval:(CGFloat)interval{
    if (xInterval) {
        xInterval=interval;
    }
}

- (void)setWaveLineWidth:(CGFloat)width{
    lineWidth=width;
}

- (void)setWaveLineColor:(CGColorRef)color{
    lineColor=color;
}

- (void)setBanchmarkHeight:(CGFloat)height{
    banchmark=height;
    if (height>=self.bounds.size.height/2) {
        waveRange=height*2;
    }else{
        waveRange=(self.bounds.size.height-height)*2;
    }
}

- (void)setFilling:(BOOL)filling{
    isFilling=filling;
}

- (void)setFillingColor:(CGColorRef)color{
    fillingColor=color;
}

- (void)setZeroPointValue:(CGFloat)value{
    zeroPointValue=value;
}

- (void)setZeroPointLineWidth:(CGFloat)width{
    zeroPointLineWidth=width;
}

@end
