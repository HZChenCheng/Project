//
//  ViewController.m
//  ProjectSet
//
//  Created by 陈诚 on 2017/5/24.
//  Copyright © 2017年 iOS_Developer. All rights reserved.
//

#import "ViewController.h"

/*
 * 空数据提示图
 */
#import "UIView+EmptyDataView.h"

/*
 * UIView的分类
 */
#import "UIView+Category.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     * 数据为空时的提示视图
     */
    {
        UIView *emptyView = [[UIView alloc] init];
        emptyView.backgroundColor = [UIColor redColor];
        emptyView.frame = CGRectMake(0, 0, 200, 400);
        emptyView.center = self.view.center;
        [emptyView showEmptyDataViewWithHintMessage:@"换一天试试吧" offSet:CGPointMake(0, 0)];
        [self.view addSubview:emptyView];
    }
    
    /*
     * UIView添加基本属性，结构体等
     */
    {
        UIView *testView = [[UIView alloc] init];
        testView.name = @"testView";
        testView.offset = 100;
        testView.point = CGPointMake(88, 99);
        NSLog(@"%@-%@-%f-%f-%f",testView,testView.name,testView.offset,testView.point.x,testView.point.y);

    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
