//
//  PostCommentVC.m
//  TestApp
//
//  Created by Karanbeer Singh on 12/16/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "PostCommentVC.h"
#import "PostCommentTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

#import "Singltonweblink.h"
#import "MBProgressHUD.h"

@interface PostCommentVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    PostCommentTableViewCell *cell;
}

@property(strong,nonatomic)  NSMutableArray *imageNames;
@property (strong,nonatomic) UILabel *lblPost;
@property(nonatomic,strong)NSMutableArray *messages;
@property(nonatomic,strong)NSMutableArray *postbyimages;
@property(nonatomic,strong)NSMutableArray *postbyname;
@property(nonatomic,strong)NSMutableArray *postbydates;
@end

@implementation PostCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f]];
    self.messages = [[NSMutableArray alloc] init ];
    self.postbyimages = [[NSMutableArray alloc] init ];
    self.postbyname=[[NSMutableArray alloc]init];
    self.postbydates=[[NSMutableArray alloc]init];
    [self.profileImage setBackgroundColor:[UIColor lightGrayColor]];
    self.profileImage.clipsToBounds = YES;
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2;
    [self.profileImage.layer setBorderWidth:2.0f];
    [self.profileImage.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
    [self.profileImage setImage:self.imgprofile];
    [self.postLabel setNumberOfLines:0];
    [self.postLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.postCommentBtn addTarget:self action:@selector(bttnsend_Action:) forControlEvents:UIControlEventTouchUpInside];

    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSDictionary *rsdictry=[[Singltonweblink createInstance]getallcomment:self.lbl_post];
    NSLog(@"%@",rsdictry);
    
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    
    if([[[[rsdictry objectForKey:@"response"] objectAtIndex:0]objectForKey:@"comment_by_id" ] intValue]!=-1)
    {
        for(int i=0;i<[[rsdictry objectForKey:@"response"] count];i++)
        {
            [self.messages addObject:[[[rsdictry objectForKey:@"response"] objectAtIndex:i] objectForKey:@"comment_text"]] ;
            [self.postbyimages addObject:[[[rsdictry objectForKey:@"response"] objectAtIndex:i] objectForKey:@"userimage"]] ;
            [_postbyname addObject:[[[rsdictry objectForKey:@"response"] objectAtIndex:i] objectForKey:@"username"]] ;
            [_postbydates addObject:[[[rsdictry objectForKey:@"response"] objectAtIndex:i] objectForKey:@"comment_date"]] ;
        }
        [self.commentsTableView reloadData];
    }
    [self.postLabel setText:_lbl_string];
}


-(void)bttnsend_Action :(id)sender
{
    if(self.postTextField.text.length>0) {
        NSDictionary *dict=  [[Singltonweblink createInstance]commntonPost:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"] :_lbl_post :self.postTextField.text];
        
        NSLog(@"%@",dict);
        if([[[dict objectForKey:@"response"] objectForKey:@"message"]isEqualToString:@"Comment posted successfully"])
        {
            [self.messages addObject:self.postTextField.text];
            [self.postbyimages addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserImage"]];
            [self.postbyname addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"]];
            
            [self.postbydates addObject:@"now"];
            [self.commentsTableView reloadData];
        }
        
        [self.postTextField resignFirstResponder];
        [self.postTextField setText:@""];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.27f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y-104, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.27f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y+104, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    
    NSString *textstring=[NSString stringWithFormat:@"%@: %@",[self.postbyname objectAtIndex:indexPath.section],[self.messages objectAtIndex:indexPath.section]];
    size=[[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(tableView.frame.size.width , 2000)];
    NSString *CellIdentifier =[NSString stringWithFormat:@"%li",(long)indexPath.section];
    cell = (PostCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return size.height+80.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_messages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier =[NSString stringWithFormat:@"%li",(long)indexPath.section];
    cell = (PostCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    CGSize textSize;
    
    if (cell == nil)
    {
        cell = [[PostCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSString *textstring=[NSString stringWithFormat:@"%@",[_messages objectAtIndex: indexPath.section]];
    
    if([[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_image"]length  ]>4)
    {
        if([[UIScreen mainScreen]bounds ].size.width==320)
        {
            textSize = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(cell.frame.size.width-22, 2000) ];
        }
        else{
            textSize = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(cell.frame.size.width-72, 2000)];
        }
        [cell.asyncPostImageView setHidden:FALSE];
    }
    else{
        if([[UIScreen mainScreen]bounds ].size.width==320){
            textSize = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(cell.frame.size.width-82, 2000)];
            
        }
        else{
            textSize = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(cell.frame.size.width-72, 2000)];
        }
        [cell.asyncPostImageView setHidden:TRUE];
    }
    [cell.lblPost setText:textstring];
    [cell.lblPost setFrame:CGRectMake(20, 61, textSize.width+50, textSize.height)];
    [cell.nameLabel setText:[_postbyname objectAtIndex:indexPath.section]];
    [cell.lbldate setText:[_postbydates objectAtIndex:indexPath.section]];
    
    NSString *imageurlprof=[NSString stringWithFormat:profimageURL,[self.postbyimages objectAtIndex:indexPath.section]];
    
    NSLog(@"%@",imageurlprof);
    
    [cell.asyncProfileImageView sd_setImageWithURL:[NSURL URLWithString:imageurlprof] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [cell.mySpinner removeFromSuperview];
    }];
    
    return cell;
}
@end
