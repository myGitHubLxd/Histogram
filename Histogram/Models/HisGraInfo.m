//
//  HisGraInfo.m
//  Histogram
//
//  Created by lixiangdong on 2017/6/19.
//  Copyright © 2017年 myself. All rights reserved.
//

#import "HisGraInfo.h"

@implementation HisGraInfo

- (instancetype)init{
    return [self initDefault];
}

- (instancetype)initDefault{
    self = [super init];
    if(self){
        
        BarPointInfo *pointInfo1 = [[BarPointInfo alloc] initX:@"0" withYvalue:0.10];
        BarPointInfo *pointInfo2 = [[BarPointInfo alloc] initX:@"1" withYvalue:0.06];
        BarPointInfo *pointInfo3 = [[BarPointInfo alloc] initX:@"2" withYvalue:0.02];
        BarPointInfo *pointInfo4 = [[BarPointInfo alloc] initX:@"3" withYvalue:0.09];
        BarPointInfo *pointInfo5 = [[BarPointInfo alloc] initX:@"4" withYvalue:0.07];
        BarPointInfo *pointInfo6 = [[BarPointInfo alloc] initX:@"5" withYvalue:0.13];
        BarPointInfo *pointInfo7 = [[BarPointInfo alloc] initX:@"6" withYvalue:0.14];
        BarPointInfo *pointInfo8 = [[BarPointInfo alloc] initX:@"7" withYvalue:0.08];
        
        _barDataArr = @[pointInfo1,pointInfo2,pointInfo3,pointInfo4,pointInfo5,pointInfo6,pointInfo7,pointInfo8];
        _changeColorMinIndex = 3;
    }
    return self;
}

@end


@implementation BarPointInfo

- (instancetype)init{
    return [self initX:@"" withYvalue:0.0];
}

- (instancetype)initX:(NSString*)xtxt withYvalue:(double)yrate{
    self = [super init];
    if(self){
        _x_txt = xtxt;
        _y_rate = yrate;
    }
    return self;
}

@end
