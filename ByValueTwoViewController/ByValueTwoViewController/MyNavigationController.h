//
//  MyNavigationController.h
//  zhuanshu
//
//  Created by timliu on 14-8-27.
//  Copyright (c) 2014年 timliu: 9925124@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationController : UINavigationController<UINavigationControllerDelegate>

@property(nonatomic, assign) BOOL isPushFinish; // 窗口完全push进来了没有

@end
