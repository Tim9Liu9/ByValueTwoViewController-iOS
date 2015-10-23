//
//  ShowViewController.m
//  ByValueTwoViewController
//
//  Created by timliu on 14-10-4.
//  Copyright (c) 2014年 timliu. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()
{
    UILabel *_label;
    int i;
}


@end

@implementation ShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    i = 0;
    NSString *str = [NSString stringWithFormat:@"当前点击次数：%d", i];
    _label.text = str;
    
    if (self.tag == 100) {
        self.title = @"delegate传值";
    }else if(self.tag == 200)
    {
        self.title = @"Block传值";
    }else if(self.tag == 300)
    {
        self.title = @"KVO传值";
    }else if(self.tag == 400)
    {
        self.title = @"消息传值";
    }
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize size =  self.view.frame.size;
    
    CGRect labelFrame = CGRectMake(10, 80, size.width - 2*10, 30);
    _label = [[UILabel alloc] initWithFrame:labelFrame];
    _label.textColor = [UIColor blackColor];
    _label.backgroundColor = [UIColor redColor];
    NSString *str = [NSString stringWithFormat:@"当前点击次数：%d", i];
    _label.text = str;
    [self.view addSubview:_label];
    
    
    // 顶部显示
    UIButton *btn_top = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_top.backgroundColor  = [UIColor grayColor];
    [btn_top setTitle:@"+1" forState:UIControlStateNormal];
    [btn_top setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn_top setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    // 设置按钮的frame
    btn_top.frame = CGRectMake(0, 0, 150, 30);
    // 设置按钮的中点（在self.view的中心）
    CGFloat centerX = size.width * 0.5f;
    CGFloat centerY = size.height * 0.5f - 100;
    btn_top.center = CGPointMake(centerX, centerY);
    [self.view addSubview:btn_top];
    
    // 给按钮绑定单击的监听器
    [btn_top addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void) btnClick:(UIButton *) btn
{
    i++;
    NSString *str = [NSString stringWithFormat:@"当前点击次数：%d", i];
    _label.text = str;
    
    if (self.tag == 100) {
        // "delegate传值";
        if ([_valueDelegate conformsToProtocol:@protocol(ValueChangedDelegate)]
            && [_valueDelegate respondsToSelector:@selector(valueChanged:)] )
        {
            NSString *str1 = [NSString stringWithFormat:@"delegate->%@", str];
            // 里面的值已经修改
            [_valueDelegate valueChanged:str1];
            
        }
    }else if(self.tag == 200)
    {
        // @"block传值";
        NSString *str3 = [NSString stringWithFormat:@"Block->%@", str];
        self.stringChangedBlock(str3, nil);
        
//        [self ChangedString:  _stringChangedBlock];
    }else if(self.tag == 300)
    {
        // @"kvo传值";
        NSString *str3 = [NSString stringWithFormat:@"KVO->%@", str];
        self.values_str = str3;
    }else if(self.tag == 400)
    {
        // @"消息传值";
        NSString *str4 = [NSString stringWithFormat:@"消息传值->%@", str];
        // 发送消息：
        [[NSNotificationCenter defaultCenter] postNotificationName:@"valueStrChangedNotification" object:str4];
    }
    
    // 是哪个按钮
    self.handler (tag);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
