//
//  OnlineUsersVC.m
//  TestApp
//
//  Created by Karanbeer Singh on 12/29/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "OnlineUsersVC.h"
#import "FriendProfileVC.h"
#import "Singltonweblink.h"
#import "MessageVC.h"
#import "DEMONavigationController.h"
#import "Header.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "ProfileVCViewController.h"



@interface OnlineUsersVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView  *scroll_maim;
    
    UITableView  *tbl_maim;
}


@end

@implementation OnlineUsersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 21)];
    [button setImage:[UIImage imageNamed:@"menu@3x.png"] forState:UIControlStateNormal];
    [button addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    self.title=@"Chat";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    
      // Do any additional setup after loading the view from its nib.
    tbl_maim =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    [tbl_maim setDelegate:self];
    [tbl_maim setDataSource:self];
    
    [tbl_maim setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tbl_maim];
    [self createGrid];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSDictionary *resp=[[Singltonweblink createInstance] getonlinefriend:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]];
    NSLog(@"%@",resp);
    _main_arry=[[resp objectForKey:@"response"] objectForKey:@"res"];
    NSLog(@"%@",_main_arry);
    if([[[_main_arry objectAtIndex:0] objectForKey:@"id"] intValue]==-1)
    {
        _main_arry=nil;
        [tbl_maim  setUserInteractionEnabled:FALSE];
    }
    else
    {
        [tbl_maim  setUserInteractionEnabled:TRUE];
    [tbl_maim reloadData];
    }
    
//15-0000083590
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_main_arry count];
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
        
    }
    
   
        UIImageView *img_frnd=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)];
        [img_frnd.layer setCornerRadius:30.0f];
        
        [img_frnd setClipsToBounds:TRUE];
        [img_frnd.layer setBorderWidth:3.0f];
        [img_frnd.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
        UIActivityIndicatorView* mySpinner=mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        mySpinner.center = CGPointMake(img_frnd.frame.size.width/2, img_frnd.frame.size.height/2);
        
        [img_frnd addSubview:mySpinner];
        // [img_frnd setImage:[UIImage imageNamed:@"img01.jpg"]];
        [img_frnd sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:profimageURL,[[_main_arry objectAtIndex:indexPath.row ]objectForKey:@"userimage"]]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            [mySpinner removeFromSuperview];
        }];
        [img_frnd setTag:indexPath.row];
        [cell addSubview:img_frnd];
        [img_frnd setUserInteractionEnabled:TRUE];
        [img_frnd addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
        
        
    UIImageView *img_country=[[UIImageView alloc]initWithFrame:CGRectMake(55, 40, 28, 28)];
    [img_country.layer setCornerRadius:14.0f];
    
    [img_country setClipsToBounds:TRUE];
    [img_country.layer setBorderWidth:1.0f];
    [img_country.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
    
    NSString *imageurlcountry=[NSString stringWithFormat:CountryImageUrl,[[[[_main_arry objectAtIndex:indexPath.row ]objectForKey:@"country"] stringByReplacingOccurrencesOfString:@" " withString:@"_"] stringByAppendingString:@".png"]];
    
    
    // [img_frnd setImage:[UIImage imageNamed:@"img01.jpg"]];
    [img_country sd_setImageWithURL:[NSURL URLWithString:imageurlcountry] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        
    }];
    
    [cell addSubview:img_country];
    
        UILabel *lbl_name=[[UILabel alloc]initWithFrame:CGRectMake(80, 10,100,20)];
        [lbl_name setTextAlignment:NSTextAlignmentCenter];
        [lbl_name setFont:[UIFont boldSystemFontOfSize:17]];
        [lbl_name setText:[[_main_arry objectAtIndex:indexPath.row ]objectForKey:@"username"]];
        [cell addSubview:lbl_name];
        UILabel *lbl_age=[[UILabel alloc]initWithFrame:CGRectMake(90, 33,100,18)];
        //[lbl_age setTextAlignment:NSTextAlignmentCenter];
        [lbl_age setText:[[_main_arry objectAtIndex:indexPath.row ]objectForKey:@"age"]];
        [cell addSubview:lbl_age];
        
        UILabel *lbl_counrty=[[UILabel alloc]initWithFrame:CGRectMake(90, 54,200,18)];
        //[lbl_counrty setTextAlignment:NSTextAlignmentCenter];
        [lbl_counrty setText:[[_main_arry objectAtIndex:indexPath.row ]objectForKey:@"country"]];
        [cell addSubview:lbl_counrty];
    
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageVC *friendProfileVCOBJ;

        friendProfileVCOBJ =[[MessageVC alloc]initWithNibName:@"MessageVC" bundle:nil];
    
    friendProfileVCOBJ.useidfrnd=[[_main_arry objectAtIndex:indexPath.row] objectForKey:@"id"];
     friendProfileVCOBJ.usefrndname=[[_main_arry objectAtIndex:indexPath.row] objectForKey:@"username"];
    friendProfileVCOBJ.dictData=_main_arry;
    [self.navigationController pushViewController:friendProfileVCOBJ animated:YES];
}
-(void)createGrid
{
    int i_limit;
    int j_limit;
    int tagger=0;
    if([_main_arry count]%2==0)
    {
        i_limit=(int)[_main_arry count]/2;
        j_limit=2;
        
        
    }
    else{
        i_limit=(int)[_main_arry count]/2;
        i_limit=i_limit+1;
        j_limit=1;
    }
    
    for( int i=0;i<i_limit;i++)
    {
        [scroll_maim setContentSize:CGSizeMake(scroll_maim.frame.size.width, i*200)];
        for(int j=0;j<j_limit;j++)
        {
            UIImageView *img_frnd=[[UIImageView alloc]initWithFrame:CGRectMake((150*j)+60, (150*i)+30, 100, 100)];
            [img_frnd.layer setCornerRadius:50.0f];
            
            [img_frnd setClipsToBounds:TRUE];
            [img_frnd.layer setBorderWidth:5.0f];
            [img_frnd.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
            UIActivityIndicatorView* mySpinner=mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            mySpinner.center = CGPointMake(img_frnd.frame.size.width/2, img_frnd.frame.size.height/2);
            
            [img_frnd addSubview:mySpinner];
            // [img_frnd setImage:[UIImage imageNamed:@"img01.jpg"]];
            [img_frnd sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:profimageURL,[[_main_arry objectAtIndex:tagger ]objectForKey:@"userimage"]]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                [mySpinner removeFromSuperview];
            }];
            [img_frnd setTag:tagger];
            [scroll_maim addSubview:img_frnd];
            [img_frnd setUserInteractionEnabled:TRUE];
            [img_frnd addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
            
            
            
            
            UILabel *lbl_name=[[UILabel alloc]initWithFrame:CGRectMake((150*j)+60, (150*i)+130, 100, 30)];
            [lbl_name setTextAlignment:NSTextAlignmentCenter];
            [lbl_name setText:[[_main_arry objectAtIndex:tagger ]objectForKey:@"username"]];
            [scroll_maim addSubview:lbl_name];
            
            tagger++;
            
        }
    }
    
    
    
    
    
    
}

-(void)panGestureRecognized :(UIGestureRecognizer*)tapper
{
    // NSLog(@"jkjkjkjk %@",_main_arry  );
    
    
    if([[[_main_arry objectAtIndex:0] objectForKey:@"id"] intValue]==[[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"] intValue])
    {
        ProfileVCViewController *profileobj=[[ProfileVCViewController alloc]init];
        [self .navigationController pushViewController:profileobj animated:YES];
    }
    else{
    
    FriendProfileVC *friendProfileVCOBJ=[[FriendProfileVC alloc]init];
    friendProfileVCOBJ.useidfrnd=[[_main_arry objectAtIndex:0] objectForKey:@"id"];
    [self.navigationController pushViewController:friendProfileVCOBJ animated:YES];
    }
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
