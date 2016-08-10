//
//  RootViewController.m
//  GoodShop
//
//  Created by mike on 5/13/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "SpeciesViewController.h"
#import "ShopCarViewController.h"
#import "UserViewController.h"
#import "CategoryViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HomeViewController *homeController = [[HomeViewController alloc] init];
    
    homeController.tabBarItem = [self createTabBarItem:NSLocalizedString(@"HomeName",@"主页 baritem 的名字")
                                            imageNamed:@"icon_main_default"
                                    selectedImageNamed:@"icon_main_click"];
    
    CategoryViewController *speciesViewController = [[CategoryViewController alloc] init];
    speciesViewController.tabBarItem = [self createTabBarItem:NSLocalizedString(@"FenLei",@"分类页 baritem 的名字")
                                                   imageNamed:@"icon_category_default"
                                           selectedImageNamed:@"icon_category_click"];
    
    ShopCarViewController *shopCarViewController = [[ShopCarViewController alloc] init];
    shopCarViewController.tabBarItem = [self createTabBarItem:NSLocalizedString(@"ShopCar",@"购物车 baritem 的名字")
                                                   imageNamed:@"icon_shopcar_default"
                                           selectedImageNamed:@"icon_shopcar_click"];
    
   
    
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeController];
    
   
    UINavigationController *speciesNavController = [[UINavigationController alloc] initWithRootViewController:speciesViewController];
    
    UINavigationController *shopCarNavController = [[UINavigationController alloc] initWithRootViewController:shopCarViewController];
    

    UserViewController *userViewController = [[UserViewController alloc] init];
    userViewController.tabBarItem = [self createTabBarItem:NSLocalizedString(@"User",@"用户的名字")
                                                imageNamed:@"icon_user_default"
                                        selectedImageNamed:@"icon_user_click"];
    UINavigationController *userViewNavController = [[UINavigationController alloc] initWithRootViewController:userViewController];
    self.viewControllers = @[homeNavController, speciesNavController, shopCarNavController, userViewNavController];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITabBarItem *)createTabBarItem:(NSString *)title imageNamed:(NSString *)imageNamed selectedImageNamed:selectedImageNamed {
    UIImage *image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                             image:image
                                                     selectedImage:selectedImage];
 
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GS_TableBarSelectColor} forState:UIControlStateSelected];

    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GS_TableBarDefaultColor} forState:UIControlStateNormal];
    
    return tabBarItem;
}

@end
