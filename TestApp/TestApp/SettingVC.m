//
//  SettingVC.m
//  TestApp
//
//  Created by Karanbeer Singh on 11/22/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "SettingVC.h"

#import "DEMONavigationController.h"
#import "Singltonweblink.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
#import "Singltonweblink.h"

#import "SCLAlertView.h"

@interface SettingVC ()<MFMailComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
     MFMailComposeViewController *mailComposer;
    NSString *strswitch_notify;
    NSString *strswitch_frndreq;
    
    UITextField *tf_oldp;
    
     UITextField *tf_newp;
}
- (void)bttnAbout_action;
- (IBAction)swtcg_frndreqst:(id)sender;
- (IBAction)swtch_notify:(id)sender;
- (IBAction)bttn_frndReqst:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblvw_backve;
@property (weak, nonatomic) IBOutlet UISwitch *swt_frndReq;
@property (weak, nonatomic) IBOutlet UISwitch *swt_notyfy;
//- (IBAction)bttn_resetPaswrdAction:(id)sender;
- (void)bttn_invitefrndaaction;
- (IBAction)bttn_notificatio_action:(id)sender;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    [button setImage:[UIImage imageNamed:@"cancel_icon.png"] forState:UIControlStateNormal];
    [button addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *buttontick = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    [buttontick setImage:[UIImage imageNamed:@"done_icon.png"] forState:UIControlStateNormal];
    [buttontick addTarget:self action:@selector(tickbttn_action) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.title=@"Settings";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttontick];

    // Do any additional setup after loading the view from its nib.
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
#pragma mark - Button Action


- (void)bttnAbout_action {
   
}

-(void)tickbttn_action
{
    NSDictionary *parsedData;
    parsedData = [[Singltonweblink createInstance]settingstatus:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"] :strswitch_frndreq :strswitch_notify ];
    parsedData = [parsedData objectForKey:@"response"];
    NSString *parsedString = [NSString stringWithFormat:@"%@", [parsedData objectForKey:@"res"]];
    if(parsedData != nil) {
        [self alertshow :1 :@"Sucess" :parsedString];
    }
    else {
        [self alertshow :1 :@"Sorry" :@"Could not complete the operation"];
    }
}

- (IBAction)swtcg_frndreqst:(id)sender {
    
    if([sender isOn])
    {
    strswitch_frndreq=[NSString stringWithFormat:@"%i",[_swt_frndReq isOn]];
    }
    else{
         strswitch_frndreq=[NSString stringWithFormat:@"%i",![_swt_frndReq isOn]];
    }
    
   
    
    
}

- (IBAction)swtch_notify:(id)sender {
    
    
    if([sender isOn])
    {
        strswitch_notify=[NSString stringWithFormat:@"%i",[_swt_notyfy isOn]];
    }
    else{
        strswitch_notify=[NSString stringWithFormat:@"%i",![_swt_notyfy isOn]];
    }
    
}

- (IBAction)bttn_frndReqst:(id)sender {
//  NSDictionary *chckrespoDict= [[Singltonweblink createInstance]CheckFrendRequst:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"]];
//    NSLog(@"%@",chckrespoDict);
}


#pragma mark - AlertView Action
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

- (IBAction)btnrest_action:(id)sender {
    if([[NSUserDefaults standardUserDefaults]integerForKey:@"facebooklogin"]==1)
    {
        [self alertshow :1 :@"Sorry" :@"To change password you need to login with  email."];
    }
    else{
    
        
        if(tf_oldp.text.length==0 || tf_newp.text.length==0)
        {
          [self alertshow :1 :@"Sorry" :@"Fill the empty fields."];  
        }
        else{
    if(![tf_oldp.text  isEqualToString:tf_newp.text])
    {
        NSDictionary *diction= [[Singltonweblink createInstance] resetPassword:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"] :tf_oldp.text :tf_newp.text];
        // NSLog(@"%@",diction);
        
        [self alertshow:1 :@"" :[[diction objectForKey:@"response"] objectForKey:@"res"]];
        
    }
    
    else
    {
        [self alertshow :1 :@"Sorry" :@"Old and new passwords are same"];
    }
    }
    }

}

- (void)bttn_invitefrndaaction {
 // NSArray *ary= [self getAllContacts];
   // NSLog(@"%@",ary);
    
    
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setCcRecipients:[NSArray arrayWithObject:@"fung.eric18@gmail.com"]];
    [mailComposer setSubject:@"I just joined Pally! Check it out!"];
    [mailComposer setMessageBody:@"Hi \n I just signedup for Pally.It's a new community for finding penpals and international friendships! \n Download it now " isHTML:YES];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result) {
        NSLog(@"Result : %d",result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)bttn_notificatio_action:(id)sender {
}
#pragma mark - FetchContacts Action

-(NSArray *)getAllContacts
{
     CFErrorRef err;
    NSMutableArray *ary=[[NSMutableArray alloc]init];
    //ABAddressBookRef addressBook = ABAddressBookCreate( );
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL,&err);
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
    CFIndex numberOfPeople = ABAddressBookGetPersonCount( addressBook );

    
    for(int i = 0; i < numberOfPeople; i++)
    {
        
        ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
        
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        [ary addObject:firstName];
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        NSLog(@"Name:%@ %@", firstName, lastName);
        
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        for (CFIndex i = 0; i < ABMultiValueGetCount(phoneNumbers); i++)
        {
            NSString *phoneNumber = (__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, i);
            NSLog(@"phone:%@", phoneNumber);
        }
        
        NSLog(@"=============================================");
        
    }
    return ary;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}





#pragma mark - UITableViewDatasource methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 250.0f;
    }
    else{
        return 80.0f;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Bubble Cell";
    
    
    
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = tableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        
        
        
        
    }
    if(indexPath.row==0)
    {
        UIImageView *lblhead=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 170, 28)];
        [lblhead setImage:[UIImage imageNamed:@"change_password.png"]];
       // [lblhead setContentMode:UIViewContentModeScaleAspectFit];
        //[lblhead setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [cell addSubview:lblhead];
        
        
        UILabel *lblold=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 200, 20)];
        [lblold setText:@"Old Password :"];
        [lblold setFont:[UIFont systemFontOfSize:14.0f]];
        [lblold setTextColor:[UIColor redColor]];
        [cell addSubview:lblold];
        
       tf_oldp=[[UITextField alloc]initWithFrame:CGRectMake(20, 90, 200, 25)];
        [tf_oldp setDelegate:self];
        [tf_oldp setBorderStyle:UITextBorderStyleRoundedRect];
        [tf_oldp.layer setCornerRadius:12.0f];
        [tf_oldp setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:237.0f/255.0f blue:233.0f/255.0f alpha:1.0]];
        [tf_oldp .layer setBorderColor:[[UIColor clearColor] CGColor] ];
        [tf_oldp .layer setBorderWidth:1.0f];
        [tf_oldp setClipsToBounds:TRUE];
        [tf_oldp setSecureTextEntry:TRUE];
        [cell addSubview:tf_oldp];
        
        
        
        UILabel *lblnew=[[UILabel alloc]initWithFrame:CGRectMake(20, 130, 200, 20)];
        [lblnew setText:@"New Password :"];
        [lblnew setFont:[UIFont systemFontOfSize:14.0f]];
        [cell addSubview:lblnew];
        
        
        
        tf_newp=[[UITextField alloc]initWithFrame:CGRectMake(20, 160, 200, 25)];
        [tf_newp setDelegate:self];
        [tf_newp setBorderStyle:UITextBorderStyleRoundedRect];
        [tf_newp.layer setCornerRadius:12.0f];
        [tf_newp setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:237.0f/255.0f blue:233.0f/255.0f alpha:1.0]];
        [tf_newp .layer setBorderColor:[[UIColor clearColor] CGColor] ];
        [tf_newp .layer setBorderWidth:1.0f];
        [tf_newp setClipsToBounds:TRUE];
        [tf_newp setSecureTextEntry:TRUE];
        [cell addSubview:tf_newp];
        
        
        
        
        UIButton *btn_reset=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn_reset setFrame:CGRectMake(20, 200, 95, 36)];
        [btn_reset setImage:[UIImage imageNamed:@"reset_button.png"] forState:UIControlStateNormal];
        [btn_reset addTarget:self action:@selector(btnrest_action:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn_reset];
    }

    else if(indexPath.row==1)
    {
        
        UIImageView *lblhead=[[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 160, 28)];
        [lblhead setImage:[UIImage imageNamed:@"friend_request.png"]];
        // [lblhead setContentMode:UIViewContentModeScaleAspectFit];
        //[lblhead setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [cell addSubview:lblhead];
        
//        UILabel *lblhead=[[UILabel alloc]initWithFrame:CGRectMake(50, 35, 200, 20)];
//        [lblhead setText:@"Friend Request"];
//        [lblhead setFont:[UIFont boldSystemFontOfSize:14.0f]];
//        [cell addSubview:lblhead];

        
        
        [_swt_frndReq setFrame:CGRectMake(self.view.frame.size.width-110, 8, 51, 31)];
        [_swt_frndReq addTarget:self action:@selector(swtcg_frndreqst:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:_swt_frndReq];
        
        
    }
    else if(indexPath.row==2)
    {
       
        UIImageView *lblhead=[[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 135, 19)];
        [lblhead setImage:[UIImage imageNamed:@"invite_friend.png"]];
        // [lblhead setContentMode:UIViewContentModeScaleAspectFit];
        //[lblhead setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [cell addSubview:lblhead];

    }
    
    else if(indexPath.row==3)
    {
       
        UIImageView *lblhead=[[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 170, 26)];
        [lblhead setImage:[UIImage imageNamed:@"notification.png"]];
        // [lblhead setContentMode:UIViewContentModeScaleAspectFit];
        //[lblhead setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [cell addSubview:lblhead];
       
        
        [_swt_notyfy setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width-110, 8, 51, 31)];
        [_swt_notyfy addTarget:self action:@selector(swtch_notify:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:_swt_notyfy];
    }
  else if(indexPath.row==4)
   {
       
       UIImageView *lblhead=[[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 112, 25)];
       [lblhead setImage:[UIImage imageNamed:@"about.png"]];
       // [lblhead setContentMode:UIViewContentModeScaleAspectFit];
       //[lblhead setFont:[UIFont boldSystemFontOfSize:14.0f]];
       [cell addSubview:lblhead];

       
//       UILabel *lblhead=[[UILabel alloc]initWithFrame:CGRectMake(50, 35, 200, 20)];
//       [lblhead setText:@"About Us"];
//       [lblhead setFont:[UIFont boldSystemFontOfSize:14.0f]];
//       [cell addSubview:lblhead];

       //[lblhead setTextColor:[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f]];
       
   }
  else{
      
  }
   
    
    
    
    
    
    
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==2)
    {
        
        [self bttn_invitefrndaaction];
        
    }
    
    else if(indexPath.row==3)
    {
        
       
    }
    else if(indexPath.row==4)
    {
        [self bttnAbout_action];
       
        
    }
    else{
        
    }

}


@end
