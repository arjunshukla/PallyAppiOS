//
//  ViewController.m
//  TestApp
//
//  Created by Karanbeer Singh on 11/18/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "ViewController.h"
#import "SignUPVC.h"
#import "ForgetPasswrdVC.h"
#import "MyHomeVC.h"

#import "MBProgressHUD.h"

#import "SCLAlertView.h"

#import "DEMONavigationController.h"
//#import "DEMOHomeViewController.h"
#import "DEMOMenuViewController.h"


#import "SDWebImage/UIImageView+WebCache.h"
#import "Singltonweblink.h"


#import <FacebookSDK/FacebookSDK.h>



@interface ViewController ()<UITextFieldDelegate,FBLoginViewDelegate>
{
    NSDictionary *response;
}
- (IBAction)sign_action:(id)sender;
- (IBAction)forgetPasswrd_action:(id)sender;
- (IBAction)signUp_action:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *vew_main;
@property (weak, nonatomic) IBOutlet UIView *vw_animating;
@property (weak, nonatomic) IBOutlet UITextField *tf_email;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BG.png"]]];
    [self.vw_animating setHidden:TRUE];
    
    
    FBLoginView *loginview =  [[FBLoginView alloc] initWithReadPermissions:
                               @[@"public_profile", @"email", @"user_friends"]];
    
    loginview.frame = CGRectOffset(loginview.frame, 5, 5);
#ifdef __IPHONE_7_0
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        if([[UIScreen mainScreen]bounds].size.height>568)
//        {
//            loginview.frame = CGRectOffset(loginview.frame, 75, self.view.frame.size.height-200);
//        }
//        else{
            loginview.frame = CGRectOffset(loginview.frame,[[UIScreen mainScreen]bounds].size.width/2-75, self.view.frame.size.height-100);
        
       // }
    }
#endif
#endif
#endif
    loginview.delegate = self;
    
    [self.vew_main addSubview:loginview];
    
    [loginview sizeToFit];

    
    
    
    
    
      
    
    
    
//    if([[[[NSUserDefaults standardUserDefaults]objectForKey:@"cityarry"] objectForKey:@"India"]count ]==0)
//    {
//    [self cityname];
//    }
    
    
    
    
  
       

   
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // [NSThread detachNewThreadSelector:@selector(cityname) toTarget:self withObject:nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
  

    [self.navigationController setNavigationBarHidden:TRUE];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]);
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]intValue ])
    {
        [self.vw_animating setHidden:FALSE];
        [self.vew_main setHidden:TRUE];
        [self animatedpally];
        
        
    }
    else{
        [self.vw_animating setHidden:TRUE];
        [self.vew_main setHidden:FALSE];
    }
    
    
    
    
    
    
}

-(void) animatedpally
{
    UIImageView *imgvw1=[[UIImageView alloc]initWithFrame:CGRectMake(self.vw_animating.frame.size.width, self.vw_animating.frame.size.height/2-100, 150, 115)];
    [imgvw1 setImage:[UIImage imageNamed:@"logolefy.png"]];
    [self.vw_animating addSubview:imgvw1];
    
    
    UIImageView *imgvw2=[[UIImageView alloc]initWithFrame:CGRectMake(-124, self.vw_animating.frame.size.height/2-68, 100, 65)];
    [imgvw2 setImage:[UIImage imageNamed:@"logorighty.png"]];
    [self.vw_animating addSubview:imgvw2];
    
    
    UIImageView *imgvw3=[[UIImageView alloc]initWithFrame:CGRectMake(self.vw_animating.frame.size.width/2-62, 0, 124, 92)];
    [imgvw3 setImage:[UIImage imageNamed:@""]];
    [self.vw_animating addSubview:imgvw3];
    
    [UIView animateWithDuration:0.5f animations:^{
        //Move the image view to 100, 100 over 10 seconds.
        imgvw1.frame = CGRectMake(self.vw_animating.frame.size.width/2-74, self.vw_animating.frame.size.height/2-100, 150, 115);
         imgvw2.frame = CGRectMake(self.vw_animating.frame.size.width/2-45, self.vw_animating.frame.size.height/2-68, 100, 65);
    }];
    
    [self performSelector:@selector(wayTohome) withObject:self afterDelay:2.5f];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - TextFields Delegate methods


- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if([_tf_email.text isEqualToString:@"Email"])
    {
        [_tf_email setText:@""];
    }
    
    if([_tf_password.text isEqualToString:@"Password"])
    {
        [_tf_password setText:@""];
    }

    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}








#pragma mark - Button Action methods



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
    [self.navigationController setNavigationBarHidden:TRUE];
    [self.navigationController pushViewController:frostedViewController animated:YES];
}

- (IBAction)sign_action:(id)sender {
    
    
    if(self.tf_email.text.length==0 || self.tf_password.text.length==0)
    {
        //alert
        [self alertshow :1 :@"Sorry!" :@"Fill the empty fields"];
    }
    else if(![self validEmail:self.tf_email.text]){
    
     [self alertshow :1 :@"Sorry!" :@"Email is not valid"];
    
    }
    else{
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"facebooklogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];

  NSDictionary *returnDictioart=[[Singltonweblink createInstance]Signin:self.tf_email.text :self.tf_password.text :[[NSUserDefaults standardUserDefaults]objectForKey:@"TokenID"] ];
    
    NSLog(@" %@",returnDictioart);
    
    if([[[returnDictioart objectForKey:@"response"]objectForKey:@"message"] isEqualToString:@"Login successfully"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:[[returnDictioart objectForKey:@"response"]objectForKey:@"id"] forKey:@"UserId"];
         [[NSUserDefaults standardUserDefaults] setObject:[[returnDictioart objectForKey:@"response"]objectForKey:@"flag"] forKey:@"UserFlag"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self wayTohome];
    }
    else{
         [self alertshow :1 :@"Sorry!" :[[returnDictioart objectForKey:@"response"]objectForKey:@"message"]];
    }
    
    
    
    }
}


- (BOOL) validEmail:(NSString*) emailString {
    
    if([emailString length]==0){
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
   
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}
-(void)firstButton
{
    
}

-(void)alertshow :(int )type : (NSString *)message :(NSString *)submessage
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    NSString *closebttntitle=@"Ok";
    if(type>1)
    {
    
    SCLButton *button = [alert addButton:@"First Button" target:self selector:@selector(firstButton)];
    closebttntitle=@"Close";
    button.layer.borderWidth = 2.0f;
    
    button.buttonFormatBlock = ^NSDictionary* (void)
    {
        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
        
        [buttonConfig setObject:[UIColor whiteColor] forKey:@"backgroundColor"];
        [buttonConfig setObject:[UIColor blackColor] forKey:@"textColor"];
        [buttonConfig setObject:[UIColor greenColor] forKey:@"borderColor"];
        
        return buttonConfig;
    };
    
    [alert addButton:@"Second Button" actionBlock:^(void) {
        NSLog(@"Second button tapped");
    }];
        
    }
    
    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [[NSBundle mainBundle] resourcePath]]];
    
    [alert showSuccess:self title:message subTitle:submessage closeButtonTitle:closebttntitle duration:0.0f];
}



- (IBAction)forgetPasswrd_action:(id)sender {
    ForgetPasswrdVC *forgetpassOBJ=[[ForgetPasswrdVC alloc]init];
    [self.navigationController pushViewController:forgetpassOBJ animated:YES];
}

- (IBAction)signUp_action:(id)sender {
    SignUPVC *signupObj;
    
//    if([[UIScreen mainScreen]bounds].size.height==568)
//    {
//        signupObj=[[SignUPVC alloc]initWithNibName:@"SignUPVC568" bundle:nil];
//    }
//    else{
        signupObj=[[SignUPVC alloc]initWithNibName:@"SignUPVC" bundle:nil];
   
   // }
     [self.navigationController pushViewController:signupObj animated:YES];
}



#pragma mark - SLider Delegate methods

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


#pragma mark - Facebook Delegate methods



- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {

}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    
  
}


- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    
    
    
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"facebooklogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"      klklklkl      %@",user);

    NSData *imgdata;
    
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *FBuser, NSError *error) {
        if (error) {
            // Handle error
        }
        
        else {
            
            
           
           
            
           
        }
    }];
    
    
    
  NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [user objectForKey:@"id"]];
     NSLog(@"%@",userImageURL);
    NSURL *url = [NSURL URLWithString: userImageURL];
    imgdata = [NSData dataWithContentsOfURL:url];
    NSLog(@"%lu",(unsigned long)imgdata.length);
    
    
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]intValue ]==0)
    {
        NSDictionary *dict=  [ [Singltonweblink createInstance]facebooklogin:[user objectForKey:@"id"] :[user objectForKey:@"email"] :[[NSUserDefaults standardUserDefaults] objectForKey:@"TokenID"] :[user objectForKey:@"name"] :imgdata];
        
        
          NSLog(@"%@",dict);
        
    
    if([[[dict objectForKey:@"response"]objectForKey:@"message"] isEqualToString:@"Login successfully"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:[[dict objectForKey:@"response"]objectForKey:@"id"] forKey:@"UserId"];
        
        [[NSUserDefaults standardUserDefaults]setObject:[user objectForKey:@"name"] forKey:@"UserName"];
        
       
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [user objectForKey:@"id"]] forKey:@"UserImage"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self wayTohome];
    }
    else{
        [self alertshow :1 :@"Sorry!" :[[dict objectForKey:@"response"]objectForKey:@"message"]];
    }
    }
    
}


- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}

#pragma mark -

// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void)performPublishAction:(void(^)(void))action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions",@"email",@"public_profile"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                } else if (error.fberrorCategory != FBErrorCategoryUserCancelled) {
                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Permission denied"
                                                                                                        message:@"Unable to get permission to post"
                                                                                                       delegate:nil
                                                                                              cancelButtonTitle:@"OK"
                                                                                              otherButtonTitles:nil];
                                                    [alertView show];
                                                }
                                            }];
    } else {
        action();
    }
    
    
}







@end
