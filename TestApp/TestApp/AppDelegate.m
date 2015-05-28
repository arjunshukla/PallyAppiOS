//
//  AppDelegate.m
//  TestApp
//
//  Created by Karanbeer Singh on 11/18/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "AppDelegate.h"

#import <UIKit/UIKit.h>

#import "MyHomeVC.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SCLAlertView.h"
#import "ViewController.h"
#import "DEMONavigationController.h"
//#import "DEMOHomeViewController.h"
#import "DEMOMenuViewController.h"
#import "MessageVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
   // [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
        {
            // iOS 8 Notifications
            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    
            [application registerForRemoteNotifications];
        }
        else
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        }
 [[UINavigationBar appearance] setBarTintColor:[UIColor  colorWithRed:0.1804 green:0.6510 blue:0.50569 alpha:0.9f]];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UINavigationController *controller = (UINavigationController*)[storyboard
//                                                                   instantiateViewControllerWithIdentifier: @"RootNavigationController"];
//    ViewController *rootViewController;
////    if([[UIScreen mainScreen] bounds].size.height>568)
////    {
////    rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
////    }
////    else{
//        rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController5"];
   // }
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   // [controller setViewControllers:[NSArray arrayWithObject:rootViewController] animated:YES];
   // self.window.rootViewController=controller;
    
   
    return YES;
}


- (void)wayTohome {
    DEMONavigationController *navigationController;
//    if([[UIScreen mainScreen] bounds].size.height>568)
//    {
        navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[MyHomeVC alloc] initWithNibName:@"MyHomeVC" bundle:nil]];
        
//    }
//    else{
//        navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[MyHomeVC alloc] initWithNibName:@"MyHomeVC5" bundle:nil]];
//    }
    
   
    DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // Create frosted view controller
    //
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleDark;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
   // [self.navigationController setNavigationBarHidden:TRUE];
   // [self.navigationController pushViewController:frostedViewController animated:YES];
    UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:frostedViewController];
    [self.window setRootViewController:nvc];
}




#pragma mark - Push Notification methods


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
    }
    
    NSDateFormatter *dfr=[[NSDateFormatter alloc]init];
    [dfr setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSLog(@"%@",[notification fireDate]);
    NSLog(@"%@",[dfr stringFromDate:[NSDate date]]);
    // NSDate *dter_crrnt=[dfr stringFromDate:[NSDate date]];
    
    
    if([[NSUserDefaults standardUserDefaults]integerForKey:@"ReminderStatus"]==1)
    {
        //        if(dter_crrnt ==[notification fireDate])
        //        {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Executive IT"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        //        }
    }
    else{
        
    }
    
    
    
}


- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                    fallbackHandler:^(FBAppCall *call) {
                        NSLog(@"In fallback handler");
                    }];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [FBAppEvents activateApp];
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActive];
}


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *str = [NSString stringWithFormat:@"Device Token=%@",deviceToken];
    
    
    
    
    NSLog(@"str %@",str);
    
    
    str=[str substringWithRange:NSMakeRange(14, 71)];
    NSLog(@"str %@",str);
    str=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    
    if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"token"] isEqualToString:str]){
        
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"tokenChanged"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"str %@",str);
    
    //94f9fbbf4881a0d279f21351aa351a11df8dd334a587c378daf56fbd0c0a9f66
    
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"TokenID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    
    
    
    
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [self getNotify:userInfo];
    
    
    NSLog(@"hello %@",userInfo);
    
    
    
}


-(void)getNotify :(NSDictionary *)userdict
{
  
    NSLog(@"hello %@",userdict);
    if([[[userdict objectForKey:@"aps"]objectForKey:@"ischatNotiKey"] isEqualToString:@"send_message"])
    {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"TestNotification"
         object:self];
 //[[NSNotificationCenter defaultCenter] postNotificationName: @"TestNotification" object:nil userInfo:userdict];
        
        
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
     [FBSession.activeSession close];
}










- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer
{
    
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController");
}



@end
