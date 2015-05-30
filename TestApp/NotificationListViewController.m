//
//  NotificationListViewController.m
//  TestApp
//
//  Created by Karanbeer Singh on 1/18/15.
//  Copyright (c) 2015 Karanbeer Singh. All rights reserved.
//

#import "NotificationListViewController.h"
#import "DEMONavigationController.h"
#import "MBProgressHUD.h"
#import "Singltonweblink.h"
#import "UIImageView+WebCache.h"
//#import "SDWebImage/UIImageView+WebCache.h"

@interface NotificationListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
     UITableView  *tbl_maim;
    NSArray *main_arry;
}
@end

@implementation NotificationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    [button setImage:[UIImage imageNamed:@"slider_icon.png"] forState:UIControlStateNormal];
    [button addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.title=@"Notifications";
    // Do any additional setup after loading the view from its nib.
    
    tbl_maim =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tbl_maim.frame.size.width, 30)];
    [tbl_maim setDelegate:self];
    [tbl_maim setDataSource:self];
    
    
    
    
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tbl_maim.frame.size.width , 30)];
    [labelView setBackgroundColor:[UIColor lightGrayColor]];
    [labelView setText:@"MARK ALL AS READ"];
    [labelView setFont:[UIFont systemFontOfSize:11]];
    [labelView setTextAlignment:NSTextAlignmentCenter];
    [headerView addSubview:labelView];
    [tbl_maim setTableHeaderView:headerView];
    
    [tbl_maim setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tbl_maim];
 [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    // Do any additional setup after loading the view from its nib.
}




-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [NSThread detachNewThreadSelector:@selector(getPosts) toTarget:self withObject:nil];
}
-(void)getPosts
{
    
    
    
    NSDictionary *resopodict=  [[Singltonweblink createInstance]GetNotificationList :[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]]];
    
  //  NSLog(@"%@",resopodict);
   main_arry=[resopodict objectForKey:@"response"];
  //   NSLog(@"%@",main_arry);
   [tbl_maim reloadData];
    
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    
    
    
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"MARK ALL AS READ";
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [main_arry count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellidentifier=[NSString stringWithFormat:@"%li",(long)indexPath];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        [cell setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, [[UIScreen mainScreen]bounds].size.width, cell.frame.size.height)];
    
        UIImageView *img_frnd=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)];
        [img_frnd.layer setCornerRadius:30.0f];
        
        [img_frnd setClipsToBounds:TRUE];
        [img_frnd.layer setBorderWidth:3.0f];
        [img_frnd.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
        UIActivityIndicatorView* mySpinner=mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        mySpinner.center = CGPointMake(img_frnd.frame.size.width/2, img_frnd.frame.size.height/2);
        
        [img_frnd addSubview:mySpinner];
        // [img_frnd setImage:[UIImage imageNamed:@"like.png"]];
        [img_frnd sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:profimageURL,[[main_arry objectAtIndex:indexPath.row ]objectForKey:@"userimage"]]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
         //   [mySpinner removeFromSuperview];
        }];
        [img_frnd setTag:indexPath.row];
        [cell addSubview:img_frnd];
        [img_frnd setUserInteractionEnabled:TRUE];
       // [img_frnd addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
        
        
        int k=(int)[[[main_arry objectAtIndex:indexPath.row ]objectForKey:@"username"] length];
         NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:[[main_arry objectAtIndex:indexPath.row ]objectForKey:@"message"]];
        
        [string addAttribute:NSFontAttributeName
                      value:[UIFont boldSystemFontOfSize:16.0f]
                      range:NSMakeRange(0, k+1)];
         // [string addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,k)];
        //[cell.lblPost setAttributedText:string];
        
        
        UILabel *lbl_name=[[UILabel alloc]initWithFrame:CGRectMake(80, 0,cell.frame.size.width-80,60)];
        [lbl_name setTextAlignment:NSTextAlignmentLeft];
        [lbl_name setFont:[UIFont systemFontOfSize:12.0f]];
    [lbl_name setNumberOfLines:0];
        [lbl_name setAttributedText:string];
       // [lbl_name setText:[[main_arry objectAtIndex:indexPath.row ]objectForKey:@"message"]];
        [cell addSubview:lbl_name];
      
    UILabel *lbl_date=[[UILabel alloc]initWithFrame:CGRectMake(120, 60,cell.frame.size.width-130,20)];
    [lbl_date setTextAlignment:NSTextAlignmentRight];
    [lbl_date setFont:[UIFont systemFontOfSize:12]];
    [lbl_date setNumberOfLines:0];
        [lbl_date setTextColor:[UIColor lightGrayColor]];
    [lbl_date setText:[[main_arry objectAtIndex:indexPath.row ]objectForKey:@"posted_date"]];
    [cell addSubview:lbl_date];
    }
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

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
