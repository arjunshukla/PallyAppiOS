//
//  DEMOMenuViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "MessageVC.h"
//#import "MessageChatVCTableViewController.h"
#import "DEMONavigationController.h"
#import "UIViewController+REFrostedViewController.h"

#import "MyHomeVC.h"
#import "FriendVC.h"
#import "ProfileVCViewController.h"
#import "SettingVC.h"
#import "SearchVC.h"
#import "SDWebImage/UIImageView+WebCache.h"

#import "OnlineUsersVC.h"
#import "Singltonweblink.h"

#import "NotificationListViewController.h"


#import <FacebookSDK/FacebookSDK.h>








@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
   }
-(void)viewDidAppear:(BOOL)animated
{
    
    
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        
        
        
        
        
       
        
        
        
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 100, 100)];
       // _imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        NSString *imageUrl;
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserImage"] hasSuffix:@"jpg"])
        {
       imageUrl=[NSString stringWithFormat:profimageURL,[[NSUserDefaults standardUserDefaults]objectForKey:@"UserImage"]];
        NSLog(@"%@",imageUrl);
        }
        else{
            imageUrl=[[NSUserDefaults standardUserDefaults]objectForKey:@"UserImage"];
              NSLog(@"%@",imageUrl);
        }
    
        UIActivityIndicatorView* mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        mySpinner.center = CGPointMake(_imageView.frame.size.width/2, _imageView.frame.size.height/2);
        
        [_imageView addSubview:mySpinner];
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            [mySpinner removeFromSuperview];
        }];

        // [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 50.0;
       [ _imageView.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
        _imageView.layer.borderWidth = 3.0f;
        _imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _imageView.layer.shouldRasterize = YES;
        _imageView.clipsToBounds = YES;
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, 115, 24)];
        
      //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"]]);
        _label.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"]];
        
        _label.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _label.backgroundColor = [UIColor clearColor];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label adjustsFontSizeToFitWidth];
        _label.textColor = [UIColor whiteColor];
      //  [_label sizeToFit];
        //_label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//         if(_label.frame.size.width>100)
//         {
//             [_label setFrame:CGRectMake(140, 100, 00, 24)];
//         }
        
         NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserFlag"]);
        _flag_imgvw=[[UIImageView alloc]initWithFrame:CGRectMake(164, 125, 30, 24)];
        [_flag_imgvw setBackgroundColor:[UIColor clearColor]];
        [_flag_imgvw setContentMode:UIViewContentModeScaleAspectFit];
        [_flag_imgvw sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserFlag"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            [mySpinner removeFromSuperview];
        }];
        
        
        UIImageView *showimgvw1=[[UIImageView alloc]initWithFrame:CGRectMake(150, 120, 100, 40)];
        //[showimgvw1 setBackgroundColor:[UIColor whiteColor]];
        [showimgvw1 setImage:[UIImage imageNamed:@"tbar.png"]];
        
        
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(208, 130, 0, 24)];
        
        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"]]);
        label2.text =@"English";
        label2.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        label2.backgroundColor = [UIColor clearColor];
        label2.textColor = [UIColor whiteColor];
        [label2 sizeToFit];

        
        
        
        
        
        
        [view addSubview:_imageView];
        [view addSubview:_label];
        [view addSubview:_flag_imgvw];
         [view addSubview:showimgvw1];
       
        [view addSubview:label2];
        view;
    });
    [super viewDidAppear:animated];
}
#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
  //  cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:17]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167.0f/255.0f green:167.0f/255.0f blue:167.0f/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"Friends Online";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        MyHomeVC *homeViewController ;
//        if([[UIScreen mainScreen]bounds].size.height==568)
//        {
//           homeViewController = [[MyHomeVC alloc] initWithNibName:@"MyHomeVC5" bundle:nil];
//        }
//        else{
           homeViewController = [[MyHomeVC alloc] initWithNibName:@"MyHomeVC" bundle:nil];
       // }
        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
    } else if (indexPath.row == 2) {
        FriendVC *homeViewController ;
        
//        if([[UIScreen mainScreen]bounds].size.height<=568)
//        {
//            homeViewController = [[FriendVC alloc] initWithNibName:@"FriendVC5" bundle:nil];
//        }
//        else{
            homeViewController = [[FriendVC alloc] initWithNibName:@"FriendVC" bundle:nil];
        //}

        
        
        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
    }
    else if (indexPath.row == 1) {
        OnlineUsersVC *homeViewController;
        
//        if([[UIScreen mainScreen]bounds].size.height<=568)
//        {
//            homeViewController = [[OnlineUsersVC alloc] initWithNibName:@"OnlineUsersVC" bundle:nil];
//        }
//        else{
       homeViewController = [[OnlineUsersVC alloc] initWithNibName:@"OnlineUsersVC" bundle:nil];
        //homeViewController.myimage=self.imageView.image;
        //}
        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
    }
    else if (indexPath.row==3)
    {
        NotificationListViewController *homeViewController;
        
//        if([[UIScreen mainScreen]bounds].size.height<=568)
//        {
//            homeViewController = [[NotificationListViewController alloc] initWithNibName:@"OnlineUsersVC" bundle:nil];
//        }
//        else{
            homeViewController = [[NotificationListViewController alloc] initWithNibName:@"NotificationListViewController" bundle:nil];
            //homeViewController.myimage=self.imageView.image;
//        }
        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:homeViewController];
       self.frostedViewController.contentViewController = navigationController;
    }
    
    else if (indexPath.row == 5) {
        SearchVC *homeViewController ;
        
        
//        if([[UIScreen mainScreen]bounds].size.height<=568)
//        {
//            homeViewController = [[SearchVC alloc] initWithNibName:@"SearchVC5" bundle:nil];
//        }
//        else{
            homeViewController = [[SearchVC alloc] initWithNibName:@"SearchVC" bundle:nil];
        //}
        
        
        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
    }
    
    
    else if (indexPath.row == 4) {
        ProfileVCViewController *homeViewController ;
       
       
            homeViewController = [[ProfileVCViewController alloc] initWithNibName:@"ProfileVCViewController" bundle:nil];
       
        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
        
    }
    
    else if (indexPath.row == 6) {
        SettingVC *homeViewController;
        
        
//        if([[UIScreen mainScreen]bounds].size.height<=568)
//        {
//            homeViewController = [[SettingVC alloc] initWithNibName:@"SettingVC5" bundle:nil];
//        }
//        else{
            homeViewController = [[SettingVC alloc] initWithNibName:@"SettingVC" bundle:nil];
       // }
        
        
        
        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
    }
    else if (indexPath.row == 7) {
        
        
        if([[NSUserDefaults standardUserDefaults]integerForKey:@"facebooklogin"]==1)
        {
            FBSession* session = [FBSession activeSession];
            [session closeAndClearTokenInformation];
            [session close];
            [FBSession setActiveSession:nil];
        }
        
       
   [[Singltonweblink createInstance]signout:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]];
       // NSLog(@"%@",respdict);
        
       
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"UserId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
         [self.frostedViewController hideMenuViewController];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
   
        NSArray *titles = @[@"Activity",@"Chats", @"Friend",@"Notifications",@"Profile",@"Search",@"Settings",@"Sign Out"];
    
    NSArray *icons=@[@"wallIcon.png",@"chatIcon.png",@"friendsIcon.png",@"notificationIcon.png",@"profileIcon.png",@"searchIcon.png",@"settingIcon.png",@"sginoutIcon.png"];
    
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [cell.imageView setImage:[UIImage imageNamed:icons[indexPath.row]]];
        cell.textLabel.text = titles[indexPath.row];
    
    
    return cell;
}

@end
