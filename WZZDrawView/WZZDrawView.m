//
//  WZZDrawView.m
//  WZZDrawDemo
//
//  Created by 王泽众 on 16/8/29.
//  Copyright © 2016年 wzz. All rights reserved.
//

#import "WZZDrawView.h"
@import QuartzCore;

@interface WZZDrawView ();

@end

@implementation WZZDrawView

- (void)hello {
    NSLog(@"hello");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _modelsArr = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _modelsArr = [NSMutableArray array];
    }
    return self;
}

//刷新
- (void)reloadData {
    [self setNeedsDisplay];
}

//擦除
- (void)clear {
    [[self modelsArr] removeAllObjects];
    [self reloadData];
}

//画点
- (void)drawPoint:(CGPoint)point color:(UIColor *)color border:(CGFloat)border {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Point;
    model.point1 = point;
    model.color = color;
    model.border = border;
    point.x+=1;
    model.point2 = point;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画线
- (void)drawLineWithPoint1:(CGPoint)point1 point2:(CGPoint)point2 color:(UIColor *)color border:(CGFloat)border {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Line;
    model.point1 = point1;
    model.point2 = point2;
    model.color = color;
    model.border = border;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画方形
- (void)drawARectWithFrame:(CGRect)frame full:(BOOL)full color:(UIColor *)color border:(CGFloat)border {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Rect;
    model.frame = frame;
    model.full = full;
    model.color = color;
    model.border = border;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画图片
- (void)drawImage:(UIImage *)image frame:(CGRect)frame {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Image;
    model.frame = frame;
    model.image = image;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画圆
- (void)drawCircleWithPoint:(CGPoint)point r:(CGFloat)r color:(UIColor *)color border:(CGFloat)border isFull:(BOOL)full {
    WZZCircle * circle = [[WZZCircle alloc] init];
    circle.O = point;
    circle.r = r;
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Circle;
    model.full = full;
    model.color = color;
    model.border = border;
    model.circle = circle;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画扇形
- (void)drawSectorWithPoint:(CGPoint)point r:(CGFloat)r startAngle:(CGFloat)sAngle endAngle:(CGFloat)eAngle isClockwise:(BOOL)isClock color:(UIColor *)color border:(CGFloat)border isFull:(BOOL)full {
    WZZCircle * circle = [[WZZCircle alloc] init];
    circle.O = point;
    circle.r = r;
    circle.startAngle = sAngle;
    circle.endAngle = eAngle;
    circle.isClock = isClock;
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Sector;
    model.color = color;
    model.full = full;
    model.border = border;
    model.circle = circle;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画文字
- (void)drawText:(NSString *)text frame:(CGRect)frame font:(UIFont *)font color:(rgba)rgba {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Text;
    model.rgba = rgba;
    model.text = text;
    model.frame = frame;
    model.font = font;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画椭圆
- (void)drawNormalCircleWithFrame:(CGRect)frame color:(UIColor *)color border:(CGFloat)border isFull:(BOOL)full {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_NormalCircle;
    model.frame = frame;
    model.full = full;
    model.border = border;
    model.color = color;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画二次贝塞尔曲线
- (void)drawBezier2WithPoint1:(CGPoint)point1 point2:(CGPoint)point2 point3:(CGPoint)point3 {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Bezier2;
    model.point1 = point1;
    model.point2 = point2;
    model.point3 = point3;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//画三次贝塞尔曲线
- (void)drawBezier2WithPoint1:(CGPoint)point1 point2:(CGPoint)point2 point3:(CGPoint)point3 point4:(CGPoint)point4 {
    WZZDrawModel * model = [[WZZDrawModel alloc] init];
    model.type = DRAWTYPE_Bezier3;
    model.point1 = point1;
    model.point2 = point2;
    model.point3 = point3;
    model.point4 = point4;
    [self.modelsArr addObject:model];
    if (_autoReload) {
        [self reloadData];
    }
}

//绘画方法
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.modelsArr enumerateObjectsUsingBlock:^(WZZDrawModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        //框颜色和宽度
        if (model.color) {
            CGContextSetStrokeColorWithColor(context, model.color.CGColor);//线框颜色
        }
        if (model.border) {
            CGContextSetLineWidth(context, model.border);//线的宽度
        }
        switch (model.type) {
            case DRAWTYPE_Point:
            {
                //画点
                CGPoint a[2] = {model.point1, model.point2};
                CGContextAddLines(context, a, 2);//添加点
                CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
            }
                break;
            case DRAWTYPE_Line:
            {
                //画线
                CGPoint a[2] = {model.point1, model.point2};
                CGContextAddLines(context, a, 2);//添加线
                CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
            }
                break;
            case DRAWTYPE_Rect:
            {
                if (model.full) {
                    CGContextFillRect(context,model.frame);//填充框
                } else {
                    CGContextStrokeRect(context,model.frame);//画方框
                }
                //矩形
                if (model.color&&model.full) {
                    CGContextSetFillColorWithColor(context, model.color.CGColor);//填充颜色
                }
                CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
            }
                break;
            case DRAWTYPE_Image:
            {
                
                /*图片*/
                [model.image drawInRect:model.frame];//在坐标中画出图片
                //                CGContextDrawImage(context, model.frame, model.image.CGImage);//使用这个使图片上下颠倒了，参考http://blog.csdn.net/koupoo/article/details/8670024
                //                 CGContextDrawTiledImage(context, CGRectMake(0, 0, 20, 20), model.image.CGImage);//平铺图
            }
                break;
            case DRAWTYPE_Circle:
            {
                CGContextAddArc(context, model.circle.O.x, model.circle.O.y, model.circle.r,  0, 2*M_PI, 1);
                
                if (model.color&&model.full) {
                    CGContextSetFillColorWithColor(context, model.color.CGColor);//填充颜色
                    CGContextDrawPath(context, kCGPathFill); //填充路径
                } else if (model.color&&!model.full) {
                    CGContextDrawPath(context, kCGPathStroke); //绘制路径
                }
            }
                break;
            case DRAWTYPE_Sector:
            {
                if (model.full) {
                    CGContextMoveToPoint(context, model.circle.O.x, model.circle.O.y);
                }
                CGContextAddArc(context, model.circle.O.x, model.circle.O.y, model.circle.r,  model.circle.startAngle/180*M_PI, model.circle.endAngle/180*M_PI, model.circle.isClock);
                if (model.color&&model.full) {
                    CGContextSetFillColorWithColor(context, model.color.CGColor);//填充颜色
                    CGContextDrawPath(context, kCGPathFill); //填充路径
                } else if (model.color&&!model.full) {
                    CGContextDrawPath(context, kCGPathStroke); //绘制路径
                }
            }
                break;
            case DRAWTYPE_Text:
            {
                CGContextSetRGBFillColor(context, model.rgba.r, model.rgba.g, model.rgba.b, model.rgba.a);//设置填充颜色
                [model.text drawInRect:model.frame withAttributes:@{NSFontAttributeName:model.font}];
                //                [model.text drawInRect:model.frame withFont:model.font];
            }
                break;
            case DRAWTYPE_Bezier2:
            {
                //二次曲线
                CGContextMoveToPoint(context, model.point1.x, model.point1.y);//设置Path的起点
                CGContextAddQuadCurveToPoint(context,model.point2.x, model.point2.y, model.point3.x, model.point3.y);//设置贝塞尔曲线的控制点坐标和终点坐标
                CGContextStrokePath(context);
            }
                break;
            case DRAWTYPE_Bezier3:
            {
                //三次曲线函数
                CGContextMoveToPoint(context, model.point1.x, model.point1.y);//设置Path的起点
                CGContextAddCurveToPoint(context,model.point2.x, model.point2.y, model.point3.x, model.point3.y, model.point4.x, model.point4.y);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
                CGContextStrokePath(context);
            }
                break;
            case DRAWTYPE_NormalCircle:
            {
                //画椭圆
                CGContextAddEllipseInRect(context, model.frame); //椭圆
                if (model.color&&model.full) {
                    CGContextSetFillColorWithColor(context, model.color.CGColor);//填充颜色
                    CGContextDrawPath(context, kCGPathFill); //填充路径
                } else if (model.color&&!model.full) {
                    CGContextDrawPath(context, kCGPathStroke); //绘制路径
                }
            }
                break;
                
            default:
                break;
        }
    }];
}

@end

//快速创建RGBA
rgba WZZRGBAMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a) {
    rgba rrr;
    rrr.r = r;
    rrr.g = g;
    rrr.b = b;
    rrr.a = a;
    return rrr;
}

@implementation WZZDrawModel
@end
@implementation WZZCircle
@end