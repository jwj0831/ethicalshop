//
//  AppDelegate.m
//  EthicalShop
//
//  Created by Woojin Joe on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SignInViewController.h"
#import "ShopTableViewController.h"
#import "DonationStatusViewController.h"
#import "QRCodeScanViewController.h"
#import "SettingsViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController= _tabBarController;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    UIViewController *shopTableViewController = [[ShopTableViewController alloc] initWithNibName:@"ShopTableViewController" bundle:nil];
    UIViewController *qrCodeScanViewController = [[QRCodeScanViewController alloc] initWithNibName:@"QRCodeScanViewController" bundle:nil]; 
    UIViewController *donationStatusViewController = [[DonationStatusViewController alloc] initWithNibName:@"DonationStatusViewController" bundle:nil];   
    UIViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil]; 
    
    UINavigationController *naviController1 = [[UINavigationController alloc] initWithRootViewController:shopTableViewController];
    UINavigationController *naviController2 = [[UINavigationController alloc] initWithRootViewController:qrCodeScanViewController];
    UINavigationController *naviController3 = [[UINavigationController alloc] initWithRootViewController:donationStatusViewController];
    UINavigationController *naviController4 = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    
    [shopTableViewController release];
    [qrCodeScanViewController release];
    [donationStatusViewController release];
    [settingsViewController release];
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:naviController1, naviController2, naviController3, naviController4, nil];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_4_3
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0f)
    {
        //greate than or equal to 5.0
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:124.0/255.0 green:94.0/255.0 blue:72.0/255.0 alpha:1]];
        [[UITabBar appearance] setTintColor:[UIColor colorWithRed:124.0/255.0 green:94.0/255.0 blue:72.0/255.0 alpha:1]];
    }
    else
    {
        //less than 5.0
        [naviController1.navigationBar setTintColor:[UIColor colorWithRed:124.0/255.0 green:94.0/255.0 blue:72.0/255.0 alpha:1.0]];
        [naviController2.navigationBar setTintColor:[UIColor colorWithRed:124.0/255.0 green:94.0/255.0 blue:72.0/255.0 alpha:1.0]];
        [naviController3.navigationBar setTintColor:[UIColor colorWithRed:124.0/255.0 green:94.0/255.0 blue:72.0/255.0 alpha:1.0]];
        [naviController4.navigationBar setTintColor:[UIColor colorWithRed:124.0/255.0 green:94.0/255.0 blue:72.0/255.0 alpha:1.0]];
        
        UIView *customTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
        [customTabBar setBackgroundColor:[UIColor colorWithRed:124.0/255.0 green:94.0/255.0 blue:72.0/255.0 alpha:1]];
        [self.tabBarController setDelegate:self];
        [[self.tabBarController tabBar] insertSubview:customTabBar atIndex:0];
        [customTabBar release];        
    }
#else
    UIView *customTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
    [customTabBar setBackgroundColor:[UIColor colorWithRed:124.0/255.0 green:94.0/255.0 blue:72.0/255.0 alpha:1]];
    [self.tabBarController setDelegate:self];
    [[self.tabBarController tabBar] insertSubview:customTabBar atIndex:0];
    [customTabBar release];
#endif
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[UserData dataFilePath]])
    {
        //userData.plist file doesn't exist in the app.
        SignInViewController *signInViewController = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
        UINavigationController *naviControllerForSignIn = [[UINavigationController alloc] initWithRootViewController:signInViewController];
        [signInViewController release];
        
        [naviControllerForSignIn.navigationBar setTintColor:[UIColor colorWithRed:124.0/255.0 green:94.0/255.0 blue:72.0/255.0 alpha:1.0]];
        
        [self.window.rootViewController presentModalViewController:naviControllerForSignIn animated:YES];
        [naviControllerForSignIn release];
    }
    [naviController1 release];
    [naviController2 release];
    [naviController3 release];
    [naviController4 release];    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
