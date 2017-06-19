//
//  HisGraInfo.h
//  Histogram
//
//  Created by lixiangdong on 2017/6/19.
//  Copyright © 2017年 myself. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BarPointInfo;
@interface HisGraInfo : NSObject

@property (nonatomic, copy) NSArray<BarPointInfo*> *barDataArr;
@property (nonatomic, assign) NSInteger changeColorMinIndex;

- (instancetype)initDefault NS_DESIGNATED_INITIALIZER;

@end


@interface BarPointInfo : NSObject
@property (nonatomic, copy) NSString *x_txt;
@property (nonatomic, assign) double y_rate;

- (instancetype)initX:(NSString*)xtxt withYvalue:(double)yrate NS_DESIGNATED_INITIALIZER;
@end
