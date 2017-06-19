//
//  ViewController.m
//  Histogram
//
//  Created by lixiangdong on 2017/6/19.
//  Copyright © 2017年 myself. All rights reserved.
//

#import "ViewController.h"
#import "BarGraphView.h"
#import "HisGraInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BarGraphView *graphView = [[BarGraphView alloc] initWithFrame:CGRectMake(10, 100, UI_IOS_WINDOW_WIDTH - 10*2, 200)];
    [self.view addSubview:graphView];
    
    [graphView showGraphBar:[[HisGraInfo alloc] initDefault]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
