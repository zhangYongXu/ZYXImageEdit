//
//  GWRootNavigationViewController.m
//  AllPeopleReading
//
//  Created by 极客天地 on 16/11/28.
//  Copyright © 2016年 极客天地. All rights reserved.
//

#import "GWRootNavigationViewController.h"
static GWRootNavigationViewControllerManager * shareIntance = nil;
@interface GWRootNavigationViewController ()

@end

@implementation GWRootNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[[GWRootNavigationViewControllerManager shareInstance] navigationVCArray] addObject:self];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
-(void)dealloc{
    [[[GWRootNavigationViewControllerManager shareInstance] navigationVCArray] removeObject:self];
}
+(NSMutableArray *)navitionVCArray{
    return [[GWRootNavigationViewControllerManager shareInstance] navigationVCArray];
}

@end
@implementation GWRootNavigationViewControllerManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationVCArray = [[NSMutableArray alloc] init];
    }
    return self;
}
+(GWRootNavigationViewControllerManager *)shareInstance{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareIntance = [[GWRootNavigationViewControllerManager alloc] init];
    });
    return shareIntance;
}
@end
