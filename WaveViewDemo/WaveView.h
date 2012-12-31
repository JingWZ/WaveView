//
//  WaveView.h
//  RecordAudio
//
//  Created by apple on 12-12-27.
//  Copyright (c) 2012年 apple. All rights reserved.
//

/*
 使用说明：
 创建一个WaveView，通过initWaveViewWithFrame: MaxValue: MinValue:，把该WaveView加入到主View当中
 如果已在xib中画好一个WaveView，则用setWaveViewMaxValue: MinValue:来初始化
 使用startWavingWithValue:来绘制默认波形
 使用以下数个set方法来设置自定义波形（可选）
 */

#import <UIKit/UIKit.h>

typedef enum {
    
    kWaveTypeDefault = 0,
    kWaveTypeMirror = 1
    
} WaveType ;

@interface WaveView : UIView

/*以下为初始化方法*/
//初始化一个WaveView，max和min中，填入需要便是波动数据的最大值和最小值
- (WaveView *)initWaveWithType:(WaveType)type Frame:(CGRect)frame MaxValue:(CGFloat)max MinValue:(CGFloat)min;
//如果已经在xib里面建了一个View，那么初始化时调用这个方法
- (WaveView *)setWaveType:(WaveType)type MaxValue:(CGFloat)max MinValue:(CGFloat)min;


/*开始波动数据*/
- (void)startWavingWithValue:(CGFloat)value;



/*以下为波形选项*/
//设置波动范围，默认为WaveView.bounds.size.height
- (void)setWaveRange:(CGFloat)range;
//设置x轴方向的间隔，默认为1.0
- (void)setXInterval:(CGFloat)interval;
//设置波形线宽度，默认为1.0
- (void)setWaveLineWidth:(CGFloat)width;
//设置波形线颜色，默认为红色
- (void)setWaveLineColor:(CGColorRef)color;
//设置基准线高度，默认为1/2WaveView.bounds.size.height
- (void)setBanchmarkHeight:(CGFloat)height;
//是否隐藏基准线，默认为否
-(void)setBanchmarkHidden:(BOOL)hidden;
//是否填充折现下方，默认为否
- (void)setFilling:(BOOL)filling;
//填充颜色，默认为黄色
- (void)setFillingColor:(CGColorRef)color;

//只对MirrorType起作用，在这个value以下的值，不显示在波形上，表现为一根直线
- (void)setZeroPointValue:(CGFloat)value;
- (void)setZeroPointLineWidth:(CGFloat)width;

@end
