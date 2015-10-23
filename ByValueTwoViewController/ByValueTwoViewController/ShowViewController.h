//
//  ShowViewController.h
//  ByValueTwoViewController
//
//  Created by timliu on 14-10-4.
//  Copyright (c) 2014年 timliu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^StringChangedBlock) (NSString *strChanged, NSString *error);

typedef void (^CompleteHandler)(NSInteger tag);



@protocol ValueChangedDelegate <NSObject>

@optional
// 数据是否改变：
- (void) valueChanged:(NSString *) changeStr;

@end

@interface ShowViewController : UIViewController


@property(nonatomic, copy) NSString *values_str;

@property(nonatomic, assign) int tag;

//@property(nonatomic, strong) UILabel *label;

// delegate
@property (nonatomic,weak) id<ValueChangedDelegate> valueDelegate;



// block
@property (nonatomic, copy) StringChangedBlock stringChangedBlock;

@property (copy, nonatomic) CompleteHandler handler;




@end
