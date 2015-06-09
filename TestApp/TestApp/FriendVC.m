//
//  FriendVC.m
//  TestApp
//
//  Created by Karanbeer Singh on 11/26/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "FriendVC.h"
#import "DEMONavigationController.h"
#import <QuartzCore/QuartzCore.h>
#import "Singltonweblink.h"
#import "FriendProfileVC.h"
#import "Header.h"
#import "FriendTableViewCell.h"
#import "MBProgressHUD.h"

#import "SCLAlertView.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface FriendVC ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
   
    NSArray *chckrespoArry;
    NSString *status;
}
@property (weak, nonatomic) IBOutlet UIView *vw_block;
@property (weak, nonatomic) IBOutlet UIView *vw_frnds;
@property (weak, nonatomic) IBOutlet UIButton *btn_myfrn;



@property (weak, nonatomic) IBOutlet UITableView *tbl_friendlist;



- (IBAction)btn_blockedUser:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_frnfreq;
- (IBAction)btn_frndRqst:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_block;
- (IBAction)btn_myfrnd:(id)sender;
@end

@implementation FriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 21)];
    [button setImage:[UIImage imageNamed:@"menu@3x.png"] forState:UIControlStateNormal];
    [button addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
 status=@"Friends";
     [NSThread detachNewThreadSelector:@selector(getfriendsBlocked) toTarget:self withObject:nil];
    
    // Do any additional setup after loading the view from its nib.
}







#pragma mark - Button Action
-(void)getfriends
{
    NSDictionary *chckrespoDict  = [[Singltonweblink createInstance]BlockedFriendList:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"]];
    NSLog(@"%@",chckrespoDict);
    chckrespoArry=[[chckrespoDict objectForKey:@"response"]objectForKey:@"res" ];
    if([[[chckrespoArry objectAtIndex:0]objectForKey:@"frnd_req_id"] intValue]<0)
    {
        chckrespoArry=nil;
        chckrespoArry =[[NSArray alloc]init];
        
       // [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
       // [self performSelector:@selector(removeHUD) withObject:nil afterDelay:2.0f];
    }
    
     [_tbl_friendlist reloadData];
   
    
}
-(void)getfriendsRequests
{
 NSDictionary *chckrespoDict  = [[Singltonweblink createInstance]CheckFrendRequst:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"]];
    NSLog(@"%@",chckrespoDict);
    chckrespoArry=[[chckrespoDict objectForKey:@"response"]objectForKey:@"res" ];
    if([[[chckrespoArry objectAtIndex:0]objectForKey:@"frnd_req_id"] intValue]<0)
    {
        chckrespoArry=nil;
        chckrespoArry =[[NSArray alloc]init];
        
        // [MBProgressHUD showHUDAddedTo:self.navigationController. view animated:YES];
        //[self performSelector:@selector(removeHUD) withObject:nil afterDelay:2.0f];
    }
    
     [_tbl_friendlist reloadData];
    
}
-(void)getfriendsBlocked
{
    NSDictionary *chckrespoDict  = [[Singltonweblink createInstance]MyFriendList:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"]];
    NSLog(@"%@",chckrespoDict);
   chckrespoArry=[[chckrespoDict objectForKey:@"response" ]objectForKey:@"res"];
    if([[[chckrespoArry objectAtIndex:0]objectForKey:@"frnd_req_id"] intValue]<0)
    {
        chckrespoArry=nil;
        chckrespoArry =[[NSArray alloc]init];
       
    }
    
    [_tbl_friendlist reloadData];
    
    
    
 
  
 
}


-(void)panGestureRecognized :(UIGestureRecognizer*)tapper
{
     UIImageView *imgv=(UIImageView *)tapper.view;
   
   
    FriendProfileVC *friendProfileVCOBJ=[[FriendProfileVC alloc]init];
    friendProfileVCOBJ.useidfrnd=[NSString stringWithFormat:@"%li",(long)[imgv tag]];
    [self.navigationController pushViewController:friendProfileVCOBJ animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)btn_blockedUser:(id)sender {
     status=@"Block";
    [_btn_block setImage:[UIImage imageNamed:@"block.png"] forState:UIControlStateNormal];
    [_btn_frnfreq setImage:[UIImage imageNamed:@"Friend_request2.png"] forState:UIControlStateNormal];
    [_btn_myfrn setImage:[UIImage imageNamed:@"Friend2.png"] forState:UIControlStateNormal];
      [NSThread detachNewThreadSelector:@selector(getfriends) toTarget:self withObject:nil];
}

- (IBAction)btn_frndRqst:(id)sender {

       status=@"FriendRequest";
      [_btn_block setImage:[UIImage imageNamed:@"block2.png"] forState:UIControlStateNormal];
    [_btn_frnfreq setImage:[UIImage imageNamed:@"Friend_requestt.png"] forState:UIControlStateNormal];
    [_btn_myfrn setImage:[UIImage imageNamed:@"Friend2.png"] forState:UIControlStateNormal];
    [NSThread detachNewThreadSelector:@selector(getfriendsRequests) toTarget:self withObject:nil];
}

- (IBAction)btn_myfrnd:(id)sender {
    
    status=@"Friends";
    
      [_btn_block setImage:[UIImage imageNamed:@"block2.png"] forState:UIControlStateNormal];
      [_btn_frnfreq setImage:[UIImage imageNamed:@"Friend_request2.png"] forState:UIControlStateNormal];
      [_btn_myfrn setImage:[UIImage imageNamed:@"Friend.png"] forState:UIControlStateNormal];
    
       [NSThread detachNewThreadSelector:@selector(getfriendsBlocked) toTarget:self withObject:nil];
}


#pragma mark - AlertView Action


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
-(void) firstButton
{
    
}






-(void)removeHUD

{
    
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
   
}





#pragma mark - UITableview Action Delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [chckrespoArry count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *CellIdentifier =[NSString stringWithFormat:@"%li",(long)indexPath.section];
  FriendTableViewCell  *cell = (FriendTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
   
    
    if (cell == nil)
    {
        //cell = [[FriendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    //    reuseIdentifier:CellIdentifier];
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FriendTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];

        
        
        
    }
    [cell setFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, cell.frame.size.height)];
    
    [cell.imVW_friend.layer setCornerRadius:cell.imVW_friend.frame.size.width/2];
    [cell.imVW_friend.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [cell.imVW_friend.layer setBorderWidth:0.0f];
    [cell.imVW_friend setClipsToBounds:YES];
    [cell.imVW_friend setTag:[[[chckrespoArry objectAtIndex:indexPath.row ] objectForKey:@"id" ] intValue]];
    
    
    
    
        NSString *imageurlprof=[NSString stringWithFormat:profimageURL,[[chckrespoArry objectAtIndex:indexPath.row ] objectForKey:@"userimage" ]];
    NSLog(@"%@",imageurlprof);
    
    
    [cell.imVW_friend sd_setImageWithURL:[NSURL URLWithString:imageurlprof] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        
    }];
    
    [cell.imVW_friend setUserInteractionEnabled:TRUE];
    [cell.imVW_friend addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
    
    [cell.imVW_country.layer setCornerRadius:cell.imVW_country.frame.size.width/2];
    [cell.imVW_country.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [cell.imVW_country.layer setBorderWidth:1.0f];
    
    [cell.imVW_country setClipsToBounds:YES];
    
    NSString *imageurlcountry=[NSString stringWithFormat:CountryImageUrl,[[[[chckrespoArry objectAtIndex:indexPath.row ] objectForKey:@"country" ] stringByReplacingOccurrencesOfString:@" " withString:@"_"] stringByAppendingString:@".png"]];
    
     NSLog(@"%@",imageurlcountry);
    
    [cell.imVW_country sd_setImageWithURL:[NSURL URLWithString:imageurlcountry] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        
    }];
    [cell.lbl_name setText:[[chckrespoArry objectAtIndex:indexPath.row] objectForKey:@"username"]];
    [cell.lbl_detail setText:[[[[chckrespoArry objectAtIndex:indexPath.row] objectForKey:@"age"] stringByAppendingString:@" , "] stringByAppendingString:[[chckrespoArry objectAtIndex:indexPath.row ]objectForKey:@"country"]]];
    
   // NSLog(@"%f",tableView.frame.size.width);
    [cell.btn_friend setFrame:CGRectMake(tableView.frame.size.width-10, cell.btn_friend.frame.origin.y, cell.btn_friend.frame.size.width, cell.btn_friend.frame.size.height)];
    
    if([status isEqualToString:@"Friends"])
    {
        [cell.btn_friend setBackgroundImage:[UIImage imageNamed:@"unfriendsR.png"] forState:UIControlStateNormal];
    [cell.btn_friend setTag:[[[chckrespoArry objectAtIndex:indexPath.row ] objectForKey:@"id" ] intValue]];
    [cell.btn_friend addTarget:self action:@selector(btnFriend_action:) forControlEvents:UIControlEventTouchDown];
    }
    else if ([status isEqualToString:@"FriendRequest"])
    {
        [cell.btn_friend setBackgroundImage:[UIImage imageNamed:@"AcceptR.png"] forState:UIControlStateNormal];
        [cell.btn_friend setTag:[[[chckrespoArry objectAtIndex:indexPath.row ] objectForKey:@"frnd_req_id" ] intValue]];
        [cell.btn_friend addTarget:self action:@selector(btnFriendreqst_action:) forControlEvents:UIControlEventTouchDown];
    }
    else{
        [cell.btn_friend setBackgroundImage:[UIImage imageNamed:@"unbockR.png"] forState:UIControlStateNormal];
        [cell.btn_friend setTag:[[[chckrespoArry objectAtIndex:indexPath.row ] objectForKey:@"id" ] intValue]];
        [cell.btn_friend addTarget:self action:@selector(btnFriendunblock_action:) forControlEvents:UIControlEventTouchDown];
    }
    
    
    
    
    
    
    
    
    
    
    return cell;
}

#pragma mark - ButtontableView Action


-(void)btnFriend_action :(id)sender
{
   NSDictionary *respdict= [[Singltonweblink createInstance]unfrienduser:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"] :[NSString stringWithFormat:@"%li",(long)[sender tag]]];
    [self alertshow:1 :[[respdict objectForKey:@"response"] objectForKey:@"res"] :@"Done"];
}
-(void)btnFriendreqst_action :(id)sender
{
   NSDictionary *resDic=  [ [Singltonweblink createInstance]AcceptFrendRequst:[NSString stringWithFormat:@"%li",(long)[sender tag]] :@"A" ];
    [self alertshow:1 :[[resDic objectForKey:@"response"] objectForKey:@"res"] :@"Done"];
}
-(void)btnFriendunblock_action :(id)sender
{
    NSDictionary *respdict= [[Singltonweblink createInstance]blockuser:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"] :[NSString stringWithFormat:@"%li",(long)[sender tag]]];
    //NSLog(@"%@",respdict);
    
    
    [self alertshow:1 :[[respdict objectForKey:@"response"] objectForKey:@"res"] :@"Done"];
}



@end
