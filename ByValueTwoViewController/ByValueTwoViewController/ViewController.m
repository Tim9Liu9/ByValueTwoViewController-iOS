//
//  ViewController.m
//  ByValueTwoViewController
//
//  Created by timliu on 14-10-4.
//  Copyright (c) 2014年 timliu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"控制器反向传值";
    
    self.showViewController = [[ShowViewController alloc] init];
    
    // delegate 的监听:特点：代码啰嗦麻烦，代码可读性差
    self.showViewController.valueDelegate = self;
    
    // Block   特点：代码可读性好，但要注意：值循环引用问题
    __unsafe_unretained ViewController *main = self; // __weak
    self.showViewController.stringChangedBlock = ^(NSString *strChanged, NSString *error){
        main.label.text = strChanged;
    };
    
    // kvo 的监听  特点：代码简洁，耦合性低,但一次只能传一个值，要记得remove
    [self.showViewController addObserver:self forKeyPath:@"values_str" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    NSLog(@"kvo");
    
    
    // 注册消息：在跨多个控制器时特别有用,但代码可维护性差，所谓多处发送，四处寻找，要记得remove。（类似于Android的广播）
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(valueStrChangedNotification:) name:@"valueStrChangedNotification" object:nil];
 
    
    
    [self btnCreate];
	
}

- (void) btnCreate {
    CGSize size =  self.view.frame.size;
    
    CGRect labelFrame = CGRectMake(10, 80, size.width - 2*10, 30);
    self.label = [[UILabel alloc] initWithFrame:labelFrame];
    self.label.textColor = [UIColor blackColor];
    self.label.backgroundColor = [UIColor redColor];
    self.label.text = @"提示";
    [self.view addSubview:self.label];
    

    
    
    
    // delegate传值
    UIButton *btn_top = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_top.backgroundColor  = [UIColor grayColor];
    [btn_top setTitle:@"delegate传值" forState:UIControlStateNormal];
    [btn_top setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn_top setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    // 设置按钮的frame
    btn_top.frame = CGRectMake(0, 0, 150, 30);
    // 设置按钮的中点（在self.view的中心）
    CGFloat centerX = size.width * 0.5f;
    CGFloat centerY = size.height * 0.5f - 100;
    btn_top.center = CGPointMake(centerX, centerY);
    [self.view addSubview:btn_top];
    // 绑定一个id
    btn_top.tag = 100;
    // 给按钮绑定单击的监听器
    [btn_top addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // block传值
    UIButton *btn_cent = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_cent.backgroundColor  = [UIColor grayColor];
    [btn_cent setTitle:@"block传值" forState:UIControlStateNormal];
    [btn_cent setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn_cent setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    btn_cent.frame = CGRectMake(0, 0, 150, 30);
    CGPoint btn2Center = btn_top.center;
    btn2Center.y += 50;
    btn_cent.tag = 200;
    btn_cent.center = btn2Center;
    [btn_cent addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_cent];
    
    // KVO传值
    UIButton *btn_bottom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_bottom.backgroundColor  = [UIColor grayColor];
    [btn_bottom setTitle:@"KVO传值" forState:UIControlStateNormal];
    [btn_bottom setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn_bottom setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    btn_bottom.frame = CGRectMake(0, 0, 150, 30);
    CGPoint btn3 = btn_top.center;
    btn3.y += 100;
    btn_bottom.tag = 300;
    btn_bottom.center = btn3;
    [btn_bottom addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_bottom];
    
    
    
    
    // 消息传值
    UIButton *btn_simple = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_simple.backgroundColor  = [UIColor grayColor];
    [btn_simple setTitle:@"消息传值" forState:UIControlStateNormal];
    [btn_simple setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn_simple setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
    btn_simple.frame = CGRectMake(0, 0, 150, 30);
    CGPoint btn4 = btn_top.center;
    btn4.y += 150;
    btn_simple.tag = 400;
    btn_simple.center = btn4;
    [btn_simple addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_simple];
    
    
    
}

- (void) btnClick:(UIButton *) btn
{
    if (btn.tag == 100)
    {
         self.showViewController.tag = 100;
    }else if(btn.tag == 200)
    {
         self.showViewController.tag = 200;
    }else if(btn.tag == 300)
    {
         self.showViewController.tag = 300;
    }else if(btn.tag == 400)
    {
         self.showViewController.tag = 400;
    }
    
    [self.navigationController pushViewController:self.showViewController animated:YES];
    
}

#pragma mark - delegate的实现
- (void)valueChanged:(NSString *)changeStr
{
    self.label.text = changeStr;
}

#pragma mark - KVO的监听实现
// NSObject的方法
// observeValueForKeyPath:ofObject:change:context:
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"keyPath:%@", keyPath);
    
    NSLog(@"object:%@", object);
    
    NSString *value = [object valueForKey:keyPath];
    NSLog(@"value=%@", value);
    
    NSLog(@"change:%@", change);
    if ([keyPath isEqualToString:@"values_str"]) {
        self.label.text =  value;
    }
}


#pragma mark - 消息的接收
-(void)valueStrChangedNotification:(NSNotification *) notification{
    
    NSString *_param = [notification object];
    self.label.text =  _param;
}


- (void) dealloc{
    //移除KVO监听：
    [self.showViewController removeObserver:self forKeyPath:@"values_str" ];
    
    //移除消息：
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"valueStrChangedNotification" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
