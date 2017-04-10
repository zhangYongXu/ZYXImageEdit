//
//  JiaMenRootViewController.m
//  JiaMen
//
//  Created by 极客天地 on 16/6/8.
//  Copyright © 2016年 极客天地. All rights reserved.
//

#import "GWRootViewController.h"



@interface GWRootViewController ()<UINavigationControllerDelegate>

@property (copy,nonatomic) NSMutableDictionary * barButtonItemDict;

@end

@implementation GWRootViewController
-(NSMutableDictionary *)barButtonItemDict{
    if(nil == _barButtonItemDict){
        _barButtonItemDict = [[NSMutableDictionary alloc] init];
    }
    return _barButtonItemDict;
}
- (void)viewDidLoad {
    //[super viewDidLoad];
    [self initNavigationBar];
    [self initData];
    [self initUI];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)initNavigationBar{
    //去掉返回按钮的标题
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithHex:AppBaseBackgroundColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHex:0xffffff];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:0xffffff],NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18]}];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"navigationBackImage"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navigationBackImage"];
    self.navigationController.navigationBar.translucent=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}
-(UIButton*)createMiddleItemWithTitle:(NSString *)title FontSize:(NSInteger)fontSize{
    UIButton * button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    button.height = 30;
    button.width = [title widthWithFont:button.titleLabel.font withLineHeight:button.height];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(middleBtnItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * view = [[UIView alloc] initWithFrame:button.bounds];
    view.height = 44;
    view.backgroundColor = [UIColor clearColor];
    button.centerY = view.height/2.0;
    [view addSubview:button];
    
    UIView * bottomLineView = [[UIView alloc] init];
    bottomLineView.width = view.width;
    bottomLineView.height = 2;
    bottomLineView.top = view.height - bottomLineView.height;
    bottomLineView.backgroundColor = [UIColor clearColor];
    
    [view addSubview:bottomLineView];
    
    self.navigationItem.titleView = view;
    
    NSDictionary * dict = @{@"button":button,@"bottomLineView":bottomLineView};
    self.barButtonItemDict[@"middle"] = dict;
    
    return button;
}
-(void)middleBtnItemClicked:(UIBarButtonItem*)sender{
    if([sender isKindOfClass:[UIButton class]]){
        UIButton * sBtn = (UIButton*)sender;
        [self clickedHandleStyleWithButton:sBtn];
    }
}

-(UIButton*)createLeftItemWithTitle:(NSString *)title FontSize:(NSInteger)fontSize{
    UIButton * button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    button.height = 30;
    button.width = [title widthWithFont:button.titleLabel.font withLineHeight:button.height];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(leftItemClickedHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * view = [[UIView alloc] initWithFrame:button.bounds];
    view.height = 44;
    view.backgroundColor = [UIColor clearColor];
    button.centerY = view.height/2.0;
    [view addSubview:button];
    
    UIView * bottomLineView = [[UIView alloc] init];
    bottomLineView.width = view.width;
    bottomLineView.height = 2;
    bottomLineView.top = view.height - bottomLineView.height;
    bottomLineView.backgroundColor = [UIColor colorWithHex:0xfdb43e];
    
    [view addSubview:bottomLineView];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    NSDictionary * dict = @{@"button":button,@"bottomLineView":bottomLineView};
    self.barButtonItemDict[@"left"] = dict;
    
    return button;
}
-(void)leftItemClickedHandle:(UIBarButtonItem *)sender{
    if([sender isKindOfClass:[UIButton class]]){
        UIButton * sBtn = (UIButton*)sender;
        [self clickedHandleStyleWithButton:sBtn];
    }
}
-(UIButton*)createRightItemWithWithTitle:(NSString *)title FontSize:(NSInteger)fontSize{
    UIButton * button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    button.height = 30;
    button.width = [title widthWithFont:button.titleLabel.font withLineHeight:button.height];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(rightItemClickedHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * view = [[UIView alloc] initWithFrame:button.bounds];
    view.height = 44;
    view.backgroundColor = [UIColor clearColor];
    button.centerY = view.height/2.0;
    [view addSubview:button];
    
    UIView * bottomLineView = [[UIView alloc] init];
    bottomLineView.width = view.width;
    bottomLineView.height = 2;
    bottomLineView.top = view.height - bottomLineView.height;
    bottomLineView.backgroundColor = [UIColor clearColor];
    
    [view addSubview:bottomLineView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    NSDictionary * dict = @{@"button":button,@"bottomLineView":bottomLineView};
    self.barButtonItemDict[@"right"] = dict;
    
    return button;
}
-(void)rightItemClickedHandle:(UIBarButtonItem *)sender{
    if([sender isKindOfClass:[UIButton class]]){
        UIButton * sBtn = (UIButton*)sender;
        [self clickedHandleStyleWithButton:sBtn];
    }
}
-(void)clickedHandleStyleWithButton:(UIButton*)button{
    UIButton * sBtn = button;
    for(NSDictionary * dict in self.barButtonItemDict.allValues){
        UIButton * button = dict[@"button"];
        UIView * bView = dict[@"bottomLineView"];
        if(button == sBtn){
            bView.backgroundColor = [UIColor colorWithHex:0xfdb43e];
        }else{
            bView.backgroundColor = [UIColor clearColor];
        }
    }
}
- (void)createLeftItemWithTitle:(NSString*)title{
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClickedHandle:)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)createLeftItemWithTitle:(NSString *)title Image:(UIImage *)image{
    UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30)];
    [button setTitleColor:[UIColor colorWithHex:0x464b4d] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setImage:image forState:UIControlStateNormal];
    button.imageEdgeInsets =  UIEdgeInsetsMake(10, 26, 10, 6);
    button.titleEdgeInsets =  UIEdgeInsetsMake(5, -20, 5, 20);
    [button addTarget:self action:@selector(leftItemClickedHandle:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)createRightItemWithImage:(UIImage *)image{
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClickedHandle:)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)createLeftItemWithImage:(UIImage *)image{
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClickedHandle:)];
    self.navigationItem.leftBarButtonItem = item;
}



@end
