//
//  BarGraphView.h
//  DrawProfit
//
//  Created by lixiangdong on 16/5/9.
//  Copyright © 2016年 myself. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HisGraInfo.h"

@interface BarGraphView : UIView


- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

- (void)showGraphBar:(HisGraInfo*)graphInfo; //显示柱状图

@end
