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
    NSData *dat;
    
}


@property(strong ,nonatomic) UIActivityIndicatorView* mySpinner2 ;

@property (strong, nonatomic)  UIToolbar *tolbr_bottom;
@property (strong, nonatomic)  UIView *view_toolbar;
@property (strong, nonatomic)  UITextField *tf_typingmessage;
@property(strong,nonatomic)  NSMutableArray *imageNames;

@property(nonatomic,strong) UIView *backImgView;
@property (strong,nonatomic) UIImageView  *asyncPostImageView;
@property (strong,nonatomic) UIImageView  *asyncProfileImageView;

@property (strong,nonatomic) UILabel *lblPost;
@property (nonatomic, strong)IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *messages;
@property(nonatomic,strong)NSMutableArray *postbyimages;
@property(nonatomic,strong)NSMutableArray *postbyname;
@property(nonatomic,strong)NSMutableArray *postbydates;
@end

@implementation PostCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dat=UIImagePNGRepresentation(_imgpost);
    //NSLog(@"%lu",(unsigned long)dat.length);
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,200,self.view.frame.size.width,245)];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
    
     self.messages = [[NSMutableArray alloc] init ];
    self.postbyimages = [[NSMutableArray alloc] init ];
    self.postbyname=[[NSMutableArray alloc]init];
     self.postbydates=[[NSMutableArray alloc]init];
    
    _backImgView =[[UIView alloc] initWithFrame:CGRectMake(0,66,345,245)];
    [_backImgView setUserInteractionEnabled:TRUE];
    [_backImgView setBackgroundColor:[UIColor whiteColor]];
    [_backImgView.layer setBorderColor:[UIColor clearColor].CGColor];
    [_backImgView.layer setBorderWidth:3.0f];
    [_backImgView.layer setCornerRadius:10.0f];
    // baseImgView.image=[UIImage imageNamed:@"base.png"];
    [self.view addSubview:_backImgView];

    _asyncProfileImageView = [[UIImageView alloc] initWithFrame: CGRectMake(11,6,45,45)];
    [_asyncProfileImageView setBackgroundColor:[UIColor lightGrayColor]];
    _asyncProfileImageView.clipsToBounds = YES;
    _asyncProfileImageView.layer.cornerRadius = _asyncProfileImageView.frame.size.width/2;
    [_asyncProfileImageView.layer setBorderWidth:2.0f];
    [_asyncProfileImageView.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
    [_asyncProfileImageView setImage:self.imgprofile];
    [_backImgView addSubview:_asyncProfileImageView];
    
    
    
   
    
 
    
    _lblPost=[[UILabel alloc]initWithFrame:CGRectZero];
    [_lblPost setNumberOfLines:0];
    
   // [_lblPost setBackgroundColor:[UIColor greenColor]];
    [_lblPost setTextAlignment:NSTextAlignmentLeft];
    [_lblPost setFont:[UIFont systemFontOfSize:14.0f]];
    [_lblPost setNumberOfLines:0];
    [_lblPost setLineBreakMode:NSLineBreakByWordWrapping];
    [_backImgView addSubview:_lblPost];
    
  

        _asyncPostImageView = [[UIImageView alloc] initWithFrame: CGRectZero];

    [_asyncPostImageView setContentMode:UIViewContentModeScaleAspectFit];
    _asyncPostImageView.clipsToBounds=YES;
    [_asyncPostImageView setUserInteractionEnabled:TRUE];
    
    _asyncPostImageView.backgroundColor=[UIColor clearColor];
    [_backImgView addSubview:_asyncPostImageView];
    
    _mySpinner2 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _mySpinner2.center = CGPointMake(_asyncPostImageView.frame.size.width/2, _asyncPostImageView.frame.size.height/2);
    
    [_asyncPostImageView addSubview:_mySpinner2];
    
    
    //_tolbr_bottom
    
    _view_toolbar=[[UIView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-100, [[UIScreen mainScreen]bounds].size.width, 100)];
    [_view_toolbar setBackgroundColor:[UIColor whiteColor]];
   // [_tolbr_bottom setTranslucent:FALSE];
  //  [_tolbr_bottom setBarTintColor:[UIColor lightGrayColor]];
    // [toolbar_bottom setBackgroundImage:[UIImage imageNamed:@"strip.png"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    UIButton *bttn_send2=[UIButton buttonWithType:UIButtonTypeCustom];
    [bttn_send2 setFrame:CGRectMake(self.view.frame.size.width-30, 24, 30, 48)];
    
    [bttn_send2 setImage:[UIImage imageNamed:@"send_cmt.png"] forState:UIControlStateNormal];
    [bttn_send2 addTarget:self action:@selector(bttnsend_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    
    _tf_typingmessage=[[UITextField alloc]initWithFrame:CGRectMake(0, 4, [[UIScreen mainScreen]bounds].size.width-30, 90)];
    
    [_tf_typingmessage setTextColor:[UIColor blackColor]];
    [_tf_typingmessage.layer setCornerRadius:2];
    [_tf_typingmessage setDelegate:self];
   // [_tf_typingmessage becomeFirstResponder];
    [_tf_typingmessage.layer setBorderWidth:2];
    [_tf_typingmessage setBackgroundColor:[UIColor whiteColor]];
    [_tf_typingmessage.layer setBorderColor:(__bridge CGColorRef)([UIColor greenColor])];
    _tf_typingmessage.clipsToBounds=YES;
    
    [_view_toolbar addSubview:_tf_typingmessage];
    [_view_toolbar addSubview:bttn_send2];
    
    
    UIImageView *imgbetoptextf=[[UIImageView alloc]initWithFrame:CGRectMake(0, 1, _tf_typingmessage.frame.size.width,1)];
    [imgbetoptextf setBackgroundColor: [UIColor darkGrayColor]];
    [_view_toolbar addSubview:imgbetoptextf];
    
    
    
    UIImageView *imgbelowtextf=[[UIImageView alloc]initWithFrame:CGRectMake(0, _tf_typingmessage.frame.size.height+1, _tf_typingmessage.frame.size.width, 4)];
    [imgbelowtextf setBackgroundColor: [UIColor redColor]];
    [_view_toolbar addSubview:imgbelowtextf];
    
     [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
//    UIBarButtonItem *OButton_send;
//    OButton_send =[[UIBarButtonItem alloc]initWithCustomView:bttn_send2];
//    
//    
//    UIBarButtonItem *OButton_sting;
//    OButton_sting =[[UIBarButtonItem alloc]initWithCustomView:_tf_typingmessage];
//    
//    NSArray *items = [NSArray arrayWithObjects:OButton_sting,OButton_send,nil];
//    _tolbr_bottom.translucent=NO;
//    [_tolbr_bottom setItems:items animated:NO];
    [self.view addSubview:_view_toolbar];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    NSDictionary *rsdictry=[[Singltonweblink createInstance]getallcomment:self.lbl_post];
    NSLog(@"%@",rsdictry);
    
     [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
   // respoarry=[rsdictry objectForKey:@"response"];
    
    if([[[[rsdictry objectForKey:@"response"] objectAtIndex:0]objectForKey:@"comment_by_id" ] intValue]!=-1)
    {
        
    
    
    for(int i=0;i<[[rsdictry objectForKey:@"response"] count];i++)
    {
        [self.messages addObject:[[[rsdictry objectForKey:@"response"] objectAtIndex:i] objectForKey:@"comment_text"]] ;
        [self.postbyimages addObject:[[[rsdictry objectForKey:@"response"] objectAtIndex:i] objectForKey:@"userimage"]] ;
        [_postbyname addObject:[[[rsdictry objectForKey:@"response"] objectAtIndex:i] objectForKey:@"username"]] ;
        [_postbydates addObject:[[[rsdictry objectForKey:@"response"] objectAtIndex:i] objectForKey:@"comment_date"]] ;
    }
       
    
    [self.tableView reloadData];
    
  if([[rsdictry objectForKey:@"response"] count]>5)
  {
    [self.tableView setContentOffset:CGPointMake(self.tableView.frame.origin.x, self.tableView.contentSize.height-self.tableView.frame.size.height) animated:YES];
  }
    }
    
     CGSize size = [[Singltonweblink createInstance]textsizer:self.lbl_string :CGSizeMake(_backImgView.frame.size.width , 2000)];
    
    
   
 
    [_backImgView setFrame:CGRectMake(_backImgView.frame.origin.x, _backImgView.frame.origin.y, self.view.frame.size.width, [self lblheightbackvw])];
    
    [_lblPost setText:_lbl_string];
    // [cell.lblPost setBackgroundColor:[UIColor greenColor]];
    [_lblPost setFrame:CGRectMake(60, 6, _backImgView.frame.size.width-60, size.height)];
    
    
   if (size.height<45.0f && dat.length>0)
    {
         [_asyncPostImageView setFrame:CGRectMake(11,55,self.view.frame.size.width-22,220)];
    }
    else if (size.height>45.0f && dat.length>0)
    {
         [_asyncPostImageView setFrame:CGRectMake(11,_lblPost.frame.size.height+16,self.view.frame.size.width-22,220)];
    }
     [_asyncPostImageView setImage:self.imgpost];
    
    [self.tableView setFrame:CGRectMake(0, [self lblheightbackvw], _tableView.frame.size.width, [[UIScreen mainScreen]bounds].size.height-100-[self lblheightbackvw])];
    
   
  
    
}
-(CGFloat)lblheightbackvw
{
    CGSize size;
    
    
    NSString *textstring=self.lbl_string;
    
    
    
size = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(_backImgView.frame.size.width , 2000)];
    
    
    
    
    NSLog(@"%f",size.height);
    if(size.height<45.0f  && dat.length==0)
        
    {
        return 70.0f;
    }
   else if (size.height<45.0f && dat.length>0)
   {
      return 300.0f;
   }
    else if (size.height>45.0f && dat.length>0)
    {
        return size.height+260.0f;
    }
    else{
        return size.height+30.0f;
    }
    
 
}

-(void)bttnsend_Action :(id)sender
{
    NSDictionary *dict=  [[Singltonweblink createInstance]commntonPost:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"] :_lbl_post :_tf_typingmessage.text];
    
    NSLog(@"%@",dict);
    if([[[dict objectForKey:@"response"] objectForKey:@"message"]isEqualToString:@"Comment posted successfully"])
    {
        
        [self.messages addObject:_tf_typingmessage.text];
      //   NSString *imageUrl=[NSString stringWithFormat:@"http://108.179.196.157/~pallyapp/dev/ws/user_image/%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserImage"]];
        [self.postbyimages addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserImage"]];
        [self.postbyname addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"]];
        
        [self.postbydates addObject:@"now"];
        [self.tableView reloadData];
       // [self.tableView setContentOffset:CGPointMake(self.tableView.frame.origin.x, self.tableView.contentSize.height-self.tableView.frame.size.height) animated:YES];
    }
    
    [_tf_typingmessage resignFirstResponder];
    [_view_toolbar setFrame:CGRectMake(_view_toolbar.frame.origin.x,self.view.frame.size.height-100, _view_toolbar.frame.size.width, _view_toolbar.frame.size.height)];
    [_tf_typingmessage setText:@""];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%f",_view_toolbar.frame.origin.y-244);
    
    if(_view_toolbar.frame.origin.y==self.view.frame.size.height-100)
    {
        [UIView animateWithDuration:0.27f animations:^{
            [self.view_toolbar setFrame:CGRectMake(_view_toolbar.frame.origin.x,_view_toolbar.frame.origin.y-204, _view_toolbar.frame.size.width, _view_toolbar.frame.size.height)];
        }];
        
    }
    NSLog(@"%f",_view_toolbar.frame.origin.y);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    [UIView animateWithDuration:0.27f animations:^{
        [_view_toolbar setFrame:CGRectMake(_view_toolbar.frame.origin.x,self.view.frame.size.height-100, _view_toolbar.frame.size.width, _view_toolbar.frame.size.height)];
    }];
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
//        size = [textstring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(tableView.frame.size.width , 2000) lineBreakMode:NSLineBreakByWordWrapping];
        
    
    NSString *CellIdentifier =[NSString stringWithFormat:@"%li",(long)indexPath.section];
    cell = (PostCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if(size.height<45.0f)
//        
//    {
//        return 55.0f;
//    }
//   
//   
//    else{
//        return size.height+20.0f;
//    }
    
    return size.height+80.0f;
    
    
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_messages count];
}

PostCommentTableViewCell *cell;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
         
//            textSize = [textstring
//                        sizeWithFont:[UIFont boldSystemFontOfSize:14]
//                        constrainedToSize:CGSizeMake(cell.frame.size.width-22, 2000)
//                        lineBreakMode:NSLineBreakByWordWrapping];
            
            
            
            
            
            textSize = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(cell.frame.size.width-22, 2000) ];

        }
        else{
            
           // [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"postboxbig.png"]]];
//            textSize = [textstring
//                        sizeWithFont:[UIFont boldSystemFontOfSize:14]
//                        constrainedToSize:CGSizeMake(cell.frame.size.width-72, 2000)
//                        lineBreakMode:NSLineBreakByWordWrapping];
        
        
            
            
            
            textSize = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(cell.frame.size.width-72, 2000)];
        
        }
        
       
        
        
        
        
        
        [cell.asyncPostImageView setHidden:FALSE];
        
        
    
    }
    else{
        
        
        
        
        
        if([[UIScreen mainScreen]bounds ].size.width==320)
        {
         textSize = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(cell.frame.size.width-82, 2000)];
            
            
        }
        else{
        textSize = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(cell.frame.size.width-72, 2000)];
            
        }
        [cell.asyncPostImageView setHidden:TRUE];
       
        
    }
    
   
    [cell.lblPost setText:textstring];
    
    [cell.lblPost setFrame:CGRectMake(20, 61, textSize.width, textSize.height)];
    
   
    
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
