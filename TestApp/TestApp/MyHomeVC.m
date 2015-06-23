//
//  MyHomeVC.m
//  TestApp
//
//  Created by Karanbeer Singh on 11/19/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "MyHomeVC.h"
#import "DEMONavigationController.h"
#import "Singltonweblink.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "homeTableViewCell.h"
#import "ProfileVCViewController.h"
#import "PostCommentVC.h"
#import "Message.h"
#import "SCLAlertView.h"
#import "MBProgressHUD.h"
#import "FriendProfileVC.h"
#import "UIViewController+CWPopup.h"

@interface MyHomeVC ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    NSData *imageData;
    NSMutableArray *main_arry;
    int pageno;
    int pagenoTemp;
    int temppostid;
    homeTableViewCell *cell;
}

@property (weak, nonatomic) IBOutlet UITableView *tbl_main;
- (IBAction)btn_photopost:(id)sender;
- (IBAction)btn_StaatusPost:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *Post_vw;
@property (weak, nonatomic) IBOutlet UILabel *lbl_imagename;
@property (weak, nonatomic) IBOutlet UIImageView *img_toPost;
@property (weak, nonatomic) IBOutlet UIImageView *img_textviwtop;
@property (weak, nonatomic) IBOutlet UITextView *tv_poststatus;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIView *homeView;
- (IBAction)btn_sharePost:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bttn_sendmessage;
@property (strong, nonatomic)  UIToolbar *tolbr_bottom;
@property (strong, nonatomic)  UITextField *tf_typingmessage;
@property (strong, nonatomic) NSMutableArray *imageNames;
@end

@implementation MyHomeVC
@synthesize imgViewWritePost,imgViewUploadPicture;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeView.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO; //To reduce gap between post button and tableview
    _tv_poststatus.text = @"CREATE POST...";
    _tv_poststatus.textColor = [UIColor lightGrayColor];
    self.title = @"Activity";
    pageno=1;
    
    // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BG.png"]]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 21)];
    [button setImage:[UIImage imageNamed:@"menu@3x.png"] forState:UIControlStateNormal];
    [button addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.imageNames=[[NSMutableArray alloc]init];
    
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bttnsend_Action:)];
    letterTapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:letterTapRecognizer];
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [NSThread detachNewThreadSelector:@selector(getPosts) toTarget:self withObject:nil];
    
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 0, 0)];
    [self.tbl_main addSubview:refreshView];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(reloadActivity) forControlEvents:UIControlEventValueChanged];
    [refreshView addSubview:self.refreshControl];
}

-(void)reloadActivity
{
    [self getPosts];
    [self.refreshControl endRefreshing];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    pagenoTemp=pageno;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
    self.useBlurForPopup = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self getPosts];
}

-(void)getPosts
{
    NSDictionary *resopodict=  [[Singltonweblink createInstance]GetPost:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]]:[NSString stringWithFormat:@"%i", pageno ]];
    
    // NSDictionary *resopodict=  [[Singltonweblink createInstance]GetPost:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]]:@"5"];
    
    NSLog(@"%@",resopodict);
    if(pageno==1)
    {
        self.imageNames=[[NSMutableArray alloc]init];
    }
    if([[[[[resopodict objectForKey:@"response"] objectForKey:@"res"] objectAtIndex:0] objectForKey:@"post_id"] intValue]>0)
    {
        temppostid=[[[[[resopodict objectForKey:@"response"] objectForKey:@"res"] objectAtIndex:0] objectForKey:@"post_id"] intValue];
        
        [self.imageNames addObjectsFromArray:[[resopodict objectForKey:@"response"] objectForKey:@"res"]];
        
        // NSLog(@"%@",self.imageNames);
        [self.tbl_main reloadData];
    }
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
}

-(void)bttnsend_Action:(UITapGestureRecognizer*)sender
{
    [_tv_poststatus resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.tolbr_bottom setFrame:CGRectMake(_tolbr_bottom.frame.origin.x,self.view.frame.size.height-300, _tolbr_bottom.frame.size.width, _tolbr_bottom.frame.size.height)];
    if([_tv_poststatus isEqual:textView]){
        if ([textView.text isEqualToString:@"CREATE POST..."]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
        [textView becomeFirstResponder];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if([_tv_poststatus isEqual:textView]){
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"CREATE POST...";
            textView.textColor = [UIColor lightGrayColor];
        }
        [textView resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UitableView  Delegate Action
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.imageNames count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    NSString *textstring=[NSString stringWithFormat:@"%@:%@",[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"username"],[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"status_text"]];
    //    if([[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_image" ] length]>4)
    //    {
    //
    //
    //         size = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(tableView.frame.size.width-60 , 2000)];
    //        size = [textstring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(tableView.frame.size.width-60 , 2000) lineBreakMode:NSLineBreakByWordWrapping];
    //
    //    }
    //    else{
    size = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(tableView.frame.size.width-60 , 2000)];
    // size = [textstring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(tableView.frame.size.width-60 , 2000) lineBreakMode:NSLineBreakByWordWrapping];
    
    //}
    NSString *CellIdentifier =[NSString stringWithFormat:@"%li",(long)indexPath.section];
    cell = (homeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(size.height<45.0f && [[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_image" ] length]<4){
        return 150.0f;
    }
    else if(size.height<45.0f && [[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_image" ] length]>4){
        return 385.0f;
    }
    else if(size.height>45.0f && [[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_image" ] length]>4){
        return size.height+80.0f+270.0f;
    }
    else{
        return size.height+160.0f;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.section);
    
    int tempindex=(int)indexPath.section;
    
    NSLog(@"%d",(tempindex+1)/10);
    NSLog(@"%d",pageno);
    if((tempindex+1)%10==0 && (tempindex+1)/10==pageno){
        pageno=pageno+1;
        [NSThread detachNewThreadSelector:@selector(getPosts) toTarget:self withObject:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier =[NSString stringWithFormat:@"%li",(long)indexPath.section];
    cell = (homeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    CGSize textSize;
    
    if (cell == nil)
    {
        cell = [[homeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier];
        //   cell.layer.cornerRadius=10.0f;
        //[cell setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:10.f]];
        
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.noOfLikes setTag:[[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_id"] intValue]];
        [cell.likeButton setTag:[[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_id"] intValue]];
        [cell.likeButton setUserInteractionEnabled:TRUE];
        [cell.likeButton addTarget:self action:@selector(likebuttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.commentButton setTag:[[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_id"] intValue]];
        [cell.commentButton setUserInteractionEnabled:TRUE];
        [cell.commentButton addTarget:self action:@selector(commentbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if([[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"like_status"] isEqualToString:@"NOT_LIKE"])
    {
        [cell.likeButton setImage:[UIImage imageNamed:@"like_not_selected_icon.png"] forState:UIControlStateNormal];
    }
    else{
        [cell.likeButton setImage:[UIImage imageNamed:@"like_selected_icon.png"] forState:UIControlStateNormal];
    }
    // NSString *textstring=[NSString stringWithFormat:@"%@:%@",[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"username"],[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"status_text"]];
    NSString *textstring=[NSString stringWithFormat:@"%@",[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"status_text"]];
    
    [cell.lblname setText:[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"username"]];
    [cell.lbldate setText:[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_date"]];
    
    if([[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_image"]length  ]>4)
    {
        textSize = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(tableView.frame.size.width-60, 2000)];
        
        if(textSize.height>55.0f)
        {
            [cell.asyncPostImageView setFrame:CGRectMake(cell.frame.origin.x, 60, self.view.frame.size.width, 220)];
            //                [cell.asyncPostImageView setFrame:CGRectMake(-1, textSize.height+15.0f, tableView.frame.size.width+22, 220)];
            [cell.noOfLikes setFrame:CGRectMake(20, textSize.height+245.0f+65.0f, 25, 14)];
            [cell.likeButton setFrame:CGRectMake(47, textSize.height+240.0f+65.0f,26, 25)];
            [cell.commentButton setFrame:CGRectMake(tableView.frame.size.width-70, textSize.height+240.0f+65.0f, 26,25)];
            [cell.noOfComments setFrame:CGRectMake(tableView.frame.size.width-110, textSize.height+245.0f+65.0f, 40, 14)];
            [cell.descLabel setFrame:CGRectMake(10, textSize.height+145.0f+155.0f, tableView.frame.size.width-20, 1)];
            [cell.lblPost setFrame:CGRectMake(20, textSize.height+245.0f, textSize.width, textSize.height)];
        }
        else
        {
            //                [cell.asyncPostImageView setFrame:CGRectMake(-1, 60, tableView.frame.size.width+22, 220)];
            [cell.asyncPostImageView setFrame:CGRectMake(cell.frame.origin.x, 60, self.view.frame.size.width, 220)];
            [cell.noOfLikes setFrame:CGRectMake(20, 283.0f+65.0f, 25, 14)];
            [cell.likeButton setFrame:CGRectMake(47, 278.0f+65.0f,26, 25)];
            [cell.commentButton setFrame:CGRectMake(tableView.frame.size.width-70,278.0f+65.0f, 26,25)];
            [cell.noOfComments setFrame:CGRectMake(tableView.frame.size.width-110, 283.0f+65.0f, 40, 14)];
            [cell.descLabel setFrame:CGRectMake(10, 283.0f+55.0f, tableView.frame.size.width-20, 1)];
            [cell.lblPost setFrame:CGRectMake(20, 6+283, textSize.width, textSize.height)];
        }
        
        cell.asyncPostImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [cell.asyncPostImageView setHidden:FALSE];
        
        NSString *imageurl=[NSString stringWithFormat:@"http://108.179.196.157/~pallyapp/dev/ws/post_image/%@",[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_image"]];
        //  NSLog(@"%@",imageurl);
        [cell.asyncPostImageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            [cell.mySpinner2 removeFromSuperview];
        }];
        
        //[cell.asyncPostImageView setImageURL:[NSURL URLWithString:imageurl]];
    }
    else{
        textSize = [[Singltonweblink createInstance]textsizer:textstring :CGSizeMake(tableView.frame.size.width-60, 2000)];
        if(textSize.height>55.0f)
        {
            [cell.noOfLikes setFrame:CGRectMake(20, textSize.height+26.0f+65.0f, 25, 14)];
            [cell.likeButton setFrame:CGRectMake(47, textSize.height+21.0f+65.0f,26, 25)];
            [cell.commentButton setFrame:CGRectMake(tableView.frame.size.width-70, textSize.height+21.0f+65.0f, 26,25)];
            [cell.noOfComments setFrame:CGRectMake(tableView.frame.size.width-110, textSize.height+26.0f+65.0f, 40, 14)];
            [cell.descLabel setFrame:CGRectMake(10, textSize.height+26.0f+55.0f, tableView.frame.size.width-20, 1)];
            [cell.lblPost setFrame:CGRectMake(20, 59, textSize.width, textSize.height)];
        }
        else{
            [cell.noOfLikes setFrame:CGRectMake(20, 53.0f+65.0f, 25, 14)];
            [cell.likeButton setFrame:CGRectMake(47, 48.0f+65.0f,26, 25)];
            [cell.commentButton setFrame:CGRectMake(tableView.frame.size.width-70,48.0f+65.0f, 26,25)];
            [cell.noOfComments setFrame:CGRectMake(tableView.frame.size.width-110, 53.0f+65.0f, 40, 14)];
            [cell.descLabel setFrame:CGRectMake(10, 53.0f+55.0f, tableView.frame.size.width-20, 1)];
            [cell.lblPost setFrame:CGRectMake(20, 59, textSize.width, textSize.height)];
        }
        [cell.asyncPostImageView setHidden:TRUE];
    }
    
    // NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:textstring];
    // NSRange range = [textstring rangeOfString:@":"];
    //  [string addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,range.location+1)];
    //[cell.lblPost setAttributedText:string];
    
    [cell.lblPost setText:textstring];
    [cell.noOfLikes setText:[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"like_count"]];
    
    if([[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"comment_count"] intValue]>0)
    {
        [cell.commentButton setImage:[UIImage imageNamed:@"comment_selected_icon.png"] forState:UIControlStateNormal];
    }
    
    [cell.noOfComments setText:[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"comment_count"]];
    
    if([[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_id"] intValue]==15)
    {
        NSLog(@"%f",textSize.height);
        NSLog(@"%lu",(unsigned long)[[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"status_text"] length]);
    }
    
    [cell.asyncPostImageView setTag:[[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_id"] intValue]];
    
    UITapGestureRecognizer *tppostimg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(asyncPostImageView_action:)];
    [tppostimg setNumberOfTapsRequired:1];
    [cell.asyncPostImageView setUserInteractionEnabled:TRUE];
    [cell.asyncPostImageView addGestureRecognizer:tppostimg];
    
    NSString *imageurlprof=[NSString stringWithFormat:profimageURL,[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"userimage"]];
    
    [cell.asyncProfileImageView sd_setImageWithURL:[NSURL URLWithString:imageurlprof] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [cell.mySpinner removeFromSuperview];
    }];
    
    [cell.asyncProfileImageView setTag:[[[self.imageNames objectAtIndex:indexPath.section]objectForKey:@"post_by_id"] intValue]];
    [cell.asyncProfileImageView setUserInteractionEnabled:TRUE];
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(asynProfile_action:)];
    letterTapRecognizer.numberOfTapsRequired = 1;
    [cell.asyncProfileImageView addGestureRecognizer:letterTapRecognizer];
    
    return cell;
}

#pragma mark - UitableviewButtons&Image Action

-(void)asynProfile_action:(UITapGestureRecognizer *)sender
{
    UIImageView *imgv=(UIImageView *)sender.view;
    
    if(imgv.tag==[[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"] intValue])
    {
        ProfileVCViewController *profileobj=[[ProfileVCViewController alloc]init];
        [self .navigationController pushViewController:profileobj animated:YES];
    }
    else{
        FriendProfileVC *friendProfileVCOBJ;
        friendProfileVCOBJ =[[FriendProfileVC alloc]initWithNibName:@"FriendProfileVC" bundle:nil];
        friendProfileVCOBJ.useidfrnd=[NSString stringWithFormat:@"%li",(long)imgv.tag];
        [self.navigationController pushViewController:friendProfileVCOBJ animated:YES];
    }
}

-(void)asyncPostImageView_action: (UITapGestureRecognizer *)sender
{
    CGRect rect=[sender.view.superview convertRect:sender.view.frame toView:self.view];
    [self.navigationController setNavigationBarHidden:TRUE];
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [backview setOpaque:NO];
    [backview setBackgroundColor:[UIColor blackColor]];
    UIImageView *imgv=(UIImageView *)sender.view;
    //NSLog(@"%ld     ,%f",(long)_tbl_main.contentSize.width,_tbl_main.contentOffset.y);
    UIImageView *tempimg=[[UIImageView alloc]initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, imgv.frame.size.width, imgv.frame.size.height)];
    [tempimg setImage:imgv.image];
    [tempimg setContentMode:UIViewContentModeScaleAspectFit];
    [backview addSubview:tempimg];
    [UIView animateWithDuration:0.5f animations:^{
        [tempimg  setFrame: CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-90)];
    }];
    
    UIButton *bttnclose=[UIButton buttonWithType:UIButtonTypeCustom];
    [bttnclose setFrame:CGRectMake(10, 15, 40, 40)];
    [bttnclose setImage:[UIImage imageNamed:@"back_buttonH.png"] forState:UIControlStateNormal];
    [bttnclose addTarget:self action:@selector(closebttn_action:) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:bttnclose];
    
    [self.view addSubview:backview];
    //    UIImageView *tempimgline=[[UIImageView alloc]initWithFrame:CGRectMake(0, backview.frame.size.height-80, backview.frame.size.width, 2)];
    //    [tempimgline setBackgroundColor:[UIColor lightGrayColor]];
    //
    //    [backview addSubview:tempimgline];
}

-(IBAction)closebttn_action:(id)sender
{
    [self.navigationController setNavigationBarHidden:FALSE];
    UIView *tempvi=[sender superview];
    [tempvi removeFromSuperview];
}

-(void)commentbuttonAction:(id)sender
{
    self.homeView.hidden = NO;
    NSLog(@"%li",(long)[sender tag]);
    cell=(homeTableViewCell *) [sender superview];
    PostCommentVC *postcommentVCOBJ=[[PostCommentVC alloc]initWithNibName:@"PostCommentVC" bundle:nil];
    postcommentVCOBJ.imgprofile=cell.asyncProfileImageView.image;
    postcommentVCOBJ.imgpost=cell.asyncPostImageView.image;
    postcommentVCOBJ.lbl_string=cell.lblPost.text;
    postcommentVCOBJ.lbl_post=[NSString stringWithFormat:@"%li",(long)[sender tag]];
//    [self.navigationController pushViewController:postcommentVCOBJ animated:YES];
    
    [self presentPopupViewController:postcommentVCOBJ animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

- (void)dismissPopup {
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
    
    self.homeView.hidden = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return touch.view == self.homeView;
}

-(void)likebuttonAction:(id)sender
{
    NSMutableDictionary *dictRespo=[[Singltonweblink createInstance]likePost:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]] :[NSString stringWithFormat:@"%li",(long)[sender tag]]];
    
    NSLog(@"%@",dictRespo );
    // NSLog(@"%@",cell.noOfLikes.text);
    
    if([[NSString stringWithFormat:@"%@",[[dictRespo objectForKey:@"response"] objectForKey:@"message"] ] isEqualToString:@"Post liked successfully"])
    {
        //[self alertshow :1 :@"Sorry!" :@"Already liked"];
        cell=(homeTableViewCell *) [sender superview];
        [cell.likeButton setImage:[UIImage imageNamed:@"like_selected_icon.png"] forState:UIControlStateNormal];
        
        cell.noOfLikes.text=[NSString stringWithFormat:@"%i",[cell.noOfLikes.text  intValue]+1 ];
    }
    else{
        if([cell.noOfLikes.text intValue]>0)
        {
            cell=(homeTableViewCell *) [sender superview];
            [cell.likeButton setImage:[UIImage imageNamed:@"like_not_selected_icon.png"] forState:UIControlStateNormal];
            cell.noOfLikes.text=[NSString stringWithFormat:@"%i",[cell.noOfLikes.text  intValue]-1 ];
        }
    }
}

#pragma mark - Button Action &ImageFetch

- (IBAction)btn_sharePost:(id)sender {
    
    if((_tv_poststatus.text.length==0 || [_tv_poststatus.text isEqualToString:@"CREATE POST..."])&& imageData.length==0)
    {
        [self alertshow :1 :@"Sorry!" :@"Empty post cannot be uploaded"];
        
    }
    else{
        if(_tv_poststatus.text.length==0 || [_tv_poststatus.text isEqualToString:@"CREATE POST..."]) {
            self.tv_poststatus.text = @"";
        }
        
        [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        NSDictionary *dictreturn= [[Singltonweblink createInstance]uplodpst:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]] :self.tv_poststatus.text :imageData];
        if([[[dictreturn objectForKey:@"response"] objectForKey:@"message"] isEqualToString:@"Post posted successfully"])
        {
            pageno=1;
            [_tv_poststatus resignFirstResponder];
            [_tv_poststatus setText:@"CREATE POST..."];
            _tv_poststatus.textColor = [UIColor lightGrayColor];
            
            [_img_toPost setImage:nil];
            imageData = nil; //To clear image data after posting status as image.
        }
        
        [NSThread detachNewThreadSelector:@selector(getPosts) toTarget:self withObject:nil];
    }
}

- (IBAction)btn_photopost:(id)sender {
    
    [_img_textviwtop setImage:[UIImage imageNamed:@"zig_zag_line2.png"]];
    [_tv_poststatus resignFirstResponder];
    
    imgViewWritePost.image = [UIImage imageNamed:@"ic-edit@3x.png"];
    imgViewUploadPicture.image = [UIImage imageNamed:@"ic-camera-select@3x.png"];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Source"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Camera"
                                                    otherButtonTitles:@"Gallery", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    NSLog(@"Second button %li",(long)buttonIndex);
    
    if(buttonIndex==2)
    {
        [_img_textviwtop setImage:[UIImage imageNamed:@"zig_zag_line.png"]];
        imgViewWritePost.image = [UIImage imageNamed:@"ic-edit-pressed@3x.png"];
        imgViewUploadPicture.image = [UIImage imageNamed:@"ic-camera@3x.png"];
    }
    else
    {
        if(buttonIndex==1)
        {
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        else if(buttonIndex==0)
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            else{
                [self alertshow :1 :@"Sorry!" :@"Camera not supporting"];
            }
        }
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *imgpost;
    imgpost = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imageData=UIImageJPEGRepresentation(imgpost, 0.3f);
    [self.lbl_imagename setText:@"IMG attached"];
    [_img_toPost setImage:imgpost];
    [picker dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)btn_StaatusPost:(id)sender {
    
    [_img_textviwtop setImage:[UIImage imageNamed:@"zig_zag_line.png"]];
    [_tv_poststatus becomeFirstResponder];
    imgViewWritePost.image = [UIImage imageNamed:@"ic-edit-pressed@3x.png"];
    imgViewUploadPicture.image = [UIImage imageNamed:@"ic-camera@3x.png"];
}
@end
