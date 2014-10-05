//
//  MyNavigationController.m
//  zhuanshu
//
//  Created by timliu on 14-8-27.
//  Copyright (c) 2014年 timliu: 9925124@qq.com. All rights reserved.
//

#import "MyNavigationController.h"

@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 添加右滑手势
    [self addSwipeRecognizer];
    self.delegate = self;
    self.isPushFinish = true;
    
}

#pragma mark 添加右滑手势
- (void)addSwipeRecognizer
{
    
    // 初始化手势并添加执行方法
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(returnView)];
    
    // 手势方向
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    // 响应的手指数
    swipeRecognizer.numberOfTouchesRequired = 1;
    
    // 添加手势
    [[self view] addGestureRecognizer:swipeRecognizer];
}

#pragma mark 返回上一级
- (void)returnView
{
    // 最低控制器无需返回
    if (self.viewControllers.count <= 1) return;
    
    // push的view完成了没有，没有完成马上返回
    if (!self.isPushFinish) {
        return;
    }
    
    // pop返回上一级
//    [self popToRootViewControllerAnimated:YES];
    [self popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark pop出栈方法
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{

    return [super popViewControllerAnimated:animated];
}


#pragma mark UINavigationControllerDelegate 显示view开始，
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    self.isPushFinish = NO;
}
// 显示view结束，这里有个动画时间间隔
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{

    self.isPushFinish = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
