//
//  ViewController.m
//  ProjectSet
//
//  Created by 陈诚 on 2017/5/24.
//  Copyright © 2017年 iOS_Developer. All rights reserved.
//

#import "ViewController.h"

#import "UIView+EmptyDataView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *emptyView = [[UIView alloc] init];
    emptyView.backgroundColor = [UIColor redColor];
    emptyView.frame = CGRectMake(0, 0, 200, 400);
    emptyView.center = self.view.center;
    [emptyView showEmptyDataViewWithHintMessage:@"换一天试试吧" offSet:CGPointMake(0, 0)];
    [self.view addSubview:emptyView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
