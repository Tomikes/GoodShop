//
//  AnimationDemoViewController.m
//  GoodShop
//
//  Created by mike on 6/24/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "AnimationDemoViewController.h"

@interface AnimationDemoViewController ()

@end

@implementation AnimationDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CATransition *ani = [CATransition animation];
    ani.type = kCATransitionFade;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
