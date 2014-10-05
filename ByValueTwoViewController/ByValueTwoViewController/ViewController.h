//
//  ViewController.h
//  ByValueTwoViewController
//
//  Created by timliu on 14-10-4.
//  Copyright (c) 2014年 timliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowViewController.h"

@interface ViewController : UIViewController<ValueChangedDelegate>

// 回传的值来显示用
@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) ShowViewController *showViewController;

@end
