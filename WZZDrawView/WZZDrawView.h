//
//  WZZDrawView.h
//  WZZDrawDemo
//
//  Created by 王泽众 on 16/8/29.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WZZDrawModel;
@class WZZCircle;

typedef enum {
    DRAWTYPE_Point,
    DRAWTYPE_Line,
    DRAWTYPE_Rect,
    DRAWTYPE_Image,
    DRAWTYPE_Circle,
    DRAWTYPE_Sector,
    DRAWTYPE_Text,
    DRAWTYPE_Bezier2,
    DRAWTYPE_Bezier3,
    DRAWTYPE_NormalCircle
}DRAWTYPE;

typedef struct rgba {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
}rgba;

@interface WZZDrawView : UIView

@property (assign, nonatomic) BOOL autoReload;

/**
 存放画线数据的数组
 */
@property (strong, nonatomic, readonly) NSMutableArray <WZZDrawModel *>* modelsArr;

/**
 刷新view
 */
- (void)reloadData;

/**
 擦除
 */
- (void)clear;

/**
 画点
 point  点坐标
 color  点的颜色
 border 点大小
 */
- (void)drawPoint:(CGPoint)point
            color:(UIColor *)color
           border:(CGFloat)border;

/**
 画线
 point1 起点
 point2 终点
 color  线颜色
 border 粗细
 */
- (void)drawLineWithPoint1:(CGPoint)point1
                    point2:(CGPoint)point2
                     color:(UIColor *)color
                    border:(CGFloat)border;

/**
 画矩形
 frame  矩形位置
 full   是否实心
 color  颜色
 border 粗细
 */
- (void)drawARectWithFrame:(CGRect)frame
                      full:(BOOL)full
                     color:(UIColor *)color
                    border:(CGFloat)border;

/**
 画圆形
 */
- (void)drawCircleWithPoint:(CGPoint)point
                          r:(CGFloat)r
                      color:(UIColor *)color
                     border:(CGFloat)border
                     isFull:(BOOL)full;

/**
 画扇形
 */
- (void)drawSectorWithPoint:(CGPoint)point
                          r:(CGFloat)r
                 startAngle:(CGFloat)sAngle
                   endAngle:(CGFloat)eAngle
                isClockwise:(BOOL)isClock
                      color:(UIColor *)color
                     border:(CGFloat)border
                     isFull:(BOOL)full;

/**
 画椭圆
 */
- (void)drawNormalCircleWithFrame:(CGRect)frame
                            color:(UIColor *)color
                           border:(CGFloat)border
                           isFull:(BOOL)full;

/**
 画图片
 */
- (void)drawImage:(UIImage *)image
            frame:(CGRect)frame;

/**
 画文字
 */
- (void)drawText:(NSString *)text
           frame:(CGRect)frame
            font:(UIFont *)font
           color:(rgba)rgba;

/**
 画二次贝塞尔曲线
 */
- (void)drawBezier2WithPoint1:(CGPoint)point1
                       point2:(CGPoint)point2
                       point3:(CGPoint)point3;

/**
 画三次贝塞尔曲线
 */
- (void)drawBezier2WithPoint1:(CGPoint)point1 
                       point2:(CGPoint)point2
                       point3:(CGPoint)point3
                       point4:(CGPoint)point4;

- (void)hello;

@end

/**
 快速创建rgba结构体
 */
rgba WZZRGBAMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a);

@interface WZZDrawModel : NSObject

@property (assign, nonatomic) DRAWTYPE type;
@property (assign, nonatomic) CGPoint point1;
@property (assign, nonatomic) CGPoint point2;
@property (assign, nonatomic) CGPoint point3;
@property (assign, nonatomic) CGPoint point4;
@property (assign, nonatomic) CGRect frame;
@property (assign, nonatomic) BOOL full;
@property (strong, nonatomic) UIColor * color;
@property (assign, nonatomic) CGFloat border;
@property (strong, nonatomic) UIImage * image;
@property (strong, nonatomic) WZZCircle * circle;
@property (strong, nonatomic) NSString * text;
/**
 只能设置文字颜色
 */
@property (assign, nonatomic) rgba rgba;
@property (strong, nonatomic) UIFont * font;

@end

@interface WZZCircle : NSObject

@property (assign, nonatomic) CGPoint O;
@property (assign, nonatomic) CGFloat r;
@property (assign, nonatomic) CGFloat startAngle;
@property (assign, nonatomic) CGFloat endAngle;
@property (assign, nonatomic) BOOL isClock;

@end