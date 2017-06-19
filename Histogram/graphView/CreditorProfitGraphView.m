//
//  ProfitGraphView.m
//  DrawProfit
//
//  Created by lixiangdong on 16/5/9.
//  Copyright © 2016年 myself. All rights reserved.
//

#import "CreditorProfitGraphView.h"
#import "PNBar.h"

#define HorizontalPointLineInstance 30.0f //横坐标距离最下方距离
#define PointXInstance 45.0f              //坐标原点离屏幕左边距离

@interface CreditorProfitGraphView () {
    CGPoint _pointZero;     //原点坐标
    CGFloat _width;         //图区域宽
    CGFloat _height;        //图区域高
    CGFloat _distanceToTop; //线头高5

    double _minProfit;
    double _maxProfit;

    UIColor *_redColor;
    UIColor *_grayColor;
}
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic) NSMutableArray *bars;
@property (nonatomic) NSMutableArray *barsTopLabels;
@property (nonatomic, strong) HisGraInfo *graphInfo;
@end

@implementation CreditorProfitGraphView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self initWithFrame:CGRectMake(10, 100, UI_IOS_WINDOW_WIDTH - 10 * 2, 200)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        //坐标原点
        _pointZero = CGPointMake(PointXInstance, frame.size.height - HorizontalPointLineInstance);
        _width = frame.size.width - PointXInstance - 20.0f;
        _height = frame.size.height - HorizontalPointLineInstance;
        
        //线头高5
        _distanceToTop = 14.0f;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initBaseData {
    if (!_bars) {
        _bars = [NSMutableArray array];
    }

    if (!_barsTopLabels) {
        _barsTopLabels = [NSMutableArray array];
    }

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < _graphInfo.barDataArr.count; i++) {
        BarPointInfo *chartInfo = [_graphInfo.barDataArr objectAtIndex:i];
        [arr addObject:[NSNumber numberWithDouble:chartInfo.y_rate]];
    }

    self.dataArray = [NSArray arrayWithArray:arr];

    if (self.dataArray.count > 0) {
        _maxProfit = ((NSNumber *) [self.dataArray valueForKeyPath:@"@max.doubleValue"]).doubleValue;
        _minProfit = ((NSNumber *) [self.dataArray valueForKeyPath:@"@min.doubleValue"]).doubleValue;
    }

    _redColor = [UIColor redColor];
    _grayColor = UIColorRGB(0xcfcfcf);
}

- (void)drawRect:(CGRect)rect {

    [self initBaseData];
    [self drawNoAction:rect];
}

- (void)drawNoAction:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, rect);
    
    //画坐标
    UIColor *drawColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0.3); //线条颜色
    CGContextSetLineWidth(context, 0.3);
    CGContextMoveToPoint(context, _pointZero.x, _pointZero.y);
    CGContextAddLineToPoint(context, _pointZero.x + _width, _pointZero.y);
    CGContextMoveToPoint(context, _pointZero.x, _pointZero.y);
    CGContextAddLineToPoint(context, _pointZero.x, 0);

    CGFloat distanceX = 0.0f;
    if (self.dataArray.count > 1) {
        distanceX = _width / (self.dataArray.count - 1);
    }
    //画表格
    UIFont *font = [UIFont systemFontOfSize:11.0f];
    CGFloat strWidth = 35.0f;
    CGFloat strHeight = 12.0f;

    //NSDictionary *attributeDic = @{NSFontAttributeName:font,NSForegroundColorAttributeName:drawColor};
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributeDic = @{NSFontAttributeName : font, NSForegroundColorAttributeName : drawColor, NSParagraphStyleAttributeName : paragraph};

    NSStringDrawingContext *drawingContext = [[NSStringDrawingContext alloc] init];
    drawingContext.minimumScaleFactor = 0.5;

    //画横线和竖线
    for (int i = 1; i < self.dataArray.count; i++) {
        //横线
        CGFloat tmpY = [self getYcoordinateByValue:((NSNumber *) [self.dataArray objectAtIndex:i]).doubleValue];
        CGContextMoveToPoint(context, _pointZero.x, tmpY);
        CGContextAddLineToPoint(context, _pointZero.x + _width, tmpY);

        //竖线
        //        CGFloat tmpY = pointZero.y - (height - distanceToTop);
        //        CGPoint startPoint = CGPointMake(pointZero.x + distanceX * i, pointZero.y);
        //        CGPoint endPoint = CGPointMake(pointZero.x + distanceX * i, tmpY);
        //        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        //        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    }
    CGContextStrokePath(context);

    //画横坐标和纵坐标
    for (int i = 0; i < self.dataArray.count; i++) {
        //横坐标标注
        CGRect horizontalRect = CGRectMake(_pointZero.x + distanceX * i - strWidth / 2.0, _pointZero.y + 3, strWidth, strHeight);
        NSString *horizontalStr = ((BarPointInfo *) [self.graphInfo.barDataArr objectAtIndex:i]).x_txt;
        [horizontalStr drawWithRect:horizontalRect options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:drawingContext];

        //纵坐标标注
        CGFloat tmpY = [self getYcoordinateByValue:((NSNumber *) [self.dataArray objectAtIndex:i]).doubleValue];
        CGRect strRect = CGRectMake(_pointZero.x - strWidth, tmpY - 7, strWidth, strHeight);
        CGFloat tmpData = ((NSNumber *) [self.dataArray objectAtIndex:i]).floatValue;
        NSString *drawYstr = [NSString stringWithFormat:@"%.1f%%", tmpData * 100];
        [drawYstr drawWithRect:strRect options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:drawingContext];
        //[drawYstr drawInRect:strRect withAttributes:];
    }
    CGContextStrokePath(context);

    //原点坐标百分比
    //    CGFloat dataDistance = (_maxProfit - _minProfit) / (self.dataArray.count - 1);
    //    CGRect zeroPointStrRect = CGRectMake(pointZero.x - strWidth, pointZero.y - 10, strWidth, strHeight);
    //    NSString *zeroPointStr = [NSString stringWithFormat:@"%.1f%%",(_minProfit - dataDistance) * 100];
    //    [zeroPointStr drawWithRect:zeroPointStrRect options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:drawingContext];

    NSString *holdTimeStr = @"持有时长（月数）";
    CGRect holdStrRect = CGRectMake(0, _pointZero.y + 17.0, rect.size.width, 14.0f);
    [holdTimeStr drawWithRect:holdStrRect options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:drawingContext];

    CGContextStrokePath(context);

    //画柱状图
    //    UIColor *color = _grayColor;
    //    for(int j = 1; j < self.dataArray.count; j++)
    //    {
    //        CGFloat minY = _minProfit;
    //        CGFloat perBarHeight = (_height - _distanceToTop) * (((NSNumber*)[self.dataArray objectAtIndex:j]).doubleValue - minY) / (_maxProfit - minY);
    //
    //        CGFloat tmpY = _pointZero.y - perBarHeight;
    //        CGPoint startPoint = CGPointMake(_pointZero.x + distanceX * j, tmpY);
    //
    //        if(self.graphInfo.minRateIndex == j)
    //        {
    //            color = _redColor;
    //        }
    //
    //        CGRect rectangle = CGRectMake(startPoint.x - 4, startPoint.y, 8, perBarHeight);
    //        CGContextSetFillColorWithColor(context, color.CGColor);
    //        CGContextAddRect(context, rectangle);
    //        CGContextFillRect(context, rectangle);
    //
    //
    //        attributeDic = @{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraph};
    //        CGRect topStrRect = CGRectMake(startPoint.x - 20, startPoint.y - 14, 40, 14);
    //        NSString *topStr = [NSString stringWithFormat:@"%.1f%%",((NSNumber*)[self.dataArray objectAtIndex:j]).floatValue * 100];
    //        [topStr drawWithRect:topStrRect options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:drawingContext];
    //    }
    //
    //    CGContextStrokePath(context);
}

/**
 * 根据y轴数值计算在坐标系位置
 */
- (CGFloat)getYcoordinateByValue:(double)value {
    CGFloat minY = _minProfit;
    CGFloat perBarHeight = (_height - _distanceToTop) * (value - minY) / (_maxProfit - minY);
    CGFloat tmpY = _pointZero.y - perBarHeight;

    return tmpY;
}

- (void)drawStrInRect:(CGRect)rect
               theStr:(NSString *)str
           attributes:(nullable NSDictionary<NSString *, id> *)attributeDic
              context:(nullable NSStringDrawingContext *)drawingContext {
    [str drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDic context:drawingContext];
}

- (void)viewCleanupForCollection:(NSMutableArray *)array {
    if (array.count) {
        [array makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [array removeAllObjects];
    }
}

- (void)showGraphBar:(HisGraInfo*)graphInfo {
    _graphInfo = graphInfo;
    if (_bars.count == 0) {
        [self initBaseData];

        [self viewCleanupForCollection:_bars];
        [self viewCleanupForCollection:_barsTopLabels];
        [self updateBar];
    }
}

- (void)updateBar {
    //Add bars
    NSInteger index = 1;

    CGFloat distanceX = 0.0f;
    if (self.dataArray.count > 1) {
        distanceX = _width / (self.dataArray.count - 1);
    }

    for (int i = 1; i < self.dataArray.count; i++) {
        UIColor *color = _grayColor;
        if (i >= self.graphInfo.changeColorMinIndex) {
            color = _redColor;
        }

        CGFloat minY = _minProfit;
        CGFloat perBarHeight = (_height - _distanceToTop) * (((NSNumber *) [self.dataArray objectAtIndex:i]).doubleValue - minY) / (_maxProfit - minY);
        CGFloat tmpY = _pointZero.y - perBarHeight;
        CGPoint startPoint = CGPointMake(_pointZero.x + distanceX * i - 5, tmpY);

        PNBar *bar;
        bar = [[PNBar alloc] initWithFrame:CGRectMake(startPoint.x, tmpY, 10, perBarHeight)];

        //Change Bar Radius
        bar.barRadius = 1.0;
        //Set Bar Animation
        bar.displayAnimated = YES;
        bar.backgroundColor = [UIColor clearColor];
        bar.barColor = color;
        bar.labelTextColor = [UIColor clearColor];

        //For Click Index
        bar.tag = index;

        [_bars addObject:bar];
        [self addSubview:bar];

        //Height Of Bar
        bar.maxDivisor = (float) _maxProfit;
        bar.grade = 1.0;
        bar.isShowNumber = YES;
        //bar.isNegative = (((NSNumber *) [self.dataArray objectAtIndex:i]).doubleValue >= 0.000001) ? NO : YES;

        UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(_pointZero.x + distanceX * i - 17, tmpY - 14, 35, 14)];
        tmpLabel.font = [UIFont systemFontOfSize:11.0f];
        tmpLabel.textColor = color;
        tmpLabel.textAlignment = NSTextAlignmentCenter;
        tmpLabel.text = [NSString stringWithFormat:@"%.1f%%", ((NSNumber *) [self.dataArray objectAtIndex:i]).floatValue * 100];
        [_barsTopLabels addObject:tmpLabel];
        [self addSubview:tmpLabel];
        
        index += 1;
    }
}

@end
