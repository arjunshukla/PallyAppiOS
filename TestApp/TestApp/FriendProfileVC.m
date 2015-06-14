//
//  FriendProfileVC.m
//  TestApp
//
//  Created by Karanbeer Singh on 12/4/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "FriendProfileVC.h"

#import "homeTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SCLAlertView.h"
#import "Singltonweblink.h"
//#import "MessageChatVCTableViewController.h"
#import "MessageVC.h"

@interface FriendProfileVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    IBOutlet  UIView *backview;
    NSDictionary *respodict;
}
@property(nonatomic,strong)IBOutlet UICollectionView *collection_home;
@property (weak, nonatomic) IBOutlet UILabel *lbl_aboutme;
@property (weak, nonatomic) IBOutlet UILabel *lbl_languages;
@property (weak, nonatomic) IBOutlet UILabel *lbl_city2;
@property (weak, nonatomic) IBOutlet UILabel *lbl_country;
@property (weak, nonatomic) IBOutlet UILabel *lbl_gender;

@property (weak, nonatomic) IBOutlet UITableView *tbl_main;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_age_gender;
@property (weak, nonatomic) IBOutlet UILabel *lbl_city;
@property (weak, nonatomic) IBOutlet UIImageView *asyncCountyvw;

@property (weak, nonatomic) IBOutlet UIButton *bttn_friendreq;
@property (weak, nonatomic) IBOutlet UIButton *bttb_blockreq;
@property (weak, nonatomic) IBOutlet UILabel *lbl_bithdate;



@property (weak, nonatomic) IBOutlet UIButton *bttn_photo;
@property (weak, nonatomic) IBOutlet UIButton *bttb_about;
@property (weak, nonatomic) IBOutlet UIButton *bttn_post;

- (IBAction)Menubtn_action:(id)sender;
- (IBAction)btnPhoto_action:(id)sender;
- (IBAction)btnAbout_action:(id)sender;
- (IBAction)btnPost_Action:(id)sender;

- (IBAction)BtnAdd_Action:(id)sender;
- (IBAction)btnMessg_action:(id)sender;
- (IBAction)btnBlock_action:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *asyncImageVw;
@end

@implementation FriendProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSLog(@"%@",_useid);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    respodict= [[Singltonweblink createInstance]GetFriendProfile:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId" ] :_useidfrnd ];
    NSLog(@"%@",respodict);
    
    
    [self.collection_home registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    
    
    [_lbl_name setText:[[respodict objectForKey:@"res" ] objectForKey:@"username" ]];
    [_lbl_city setText:[[respodict objectForKey:@"res" ] objectForKey:@"city" ]];
    
    [_lbl_age_gender setText:[[[respodict objectForKey:@"res" ] objectForKey:@"age" ] stringByAppendingString:[NSString stringWithFormat:@", %@",[[respodict objectForKey:@"res" ] objectForKey:@"language" ]]]];
    
    
    
    if([[[respodict objectForKey:@"res" ] objectForKey:@"isfriend" ] isEqualToString:@"ALREADY_SEND"])
    {
        [_bttn_friendreq setImage:[UIImage imageNamed:@"friend_request_sent_button.png"] forState:UIControlStateNormal];
    }
    else if ([[[respodict objectForKey:@"res" ] objectForKey:@"isfriend" ] isEqualToString:@"FRIEND"])
    {
        //        [_bttn_friendreq setImage:[UIImage imageNamed:@"unfriend_button.png"] forState:UIControlStateNormal];
        [_bttn_friendreq setTitle:@"Unfriend" forState:UIControlStateNormal];
    }
    else{
        [_bttn_friendreq setImage:[UIImage imageNamed:@"add_friendg.png"] forState:UIControlStateNormal];
    }
    
    
    
    if ([[[respodict objectForKey:@"res" ] objectForKey:@"block_status" ] isEqualToString:@"NOT_BLOCK"])
    {
        [_bttb_blockreq setImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
    }
    else{
        [_bttb_blockreq setImage:[UIImage imageNamed:@"unblockfrnd.png"] forState:UIControlStateNormal];
    }
    
    
    
    //[backview setBackgroundColor:[UIColor clearColor]];
    
    [_lbl_country setText:[[respodict objectForKey:@"res" ] objectForKey:@"country" ] ];
    [_lbl_city2 setText:[[respodict objectForKey:@"res" ] objectForKey:@"city" ]];
    [_lbl_gender setText:[[respodict objectForKey:@"res" ] objectForKey:@"gender" ]];
    [_lbl_bithdate setText:[[respodict objectForKey:@"res" ] objectForKey:@"dob" ]];
    [_lbl_languages setText:[[respodict objectForKey:@"res" ] objectForKey:@"languages" ]];
    [_lbl_aboutme setText:[[respodict objectForKey:@"res" ] objectForKey:@"description" ]];
    
    
    [backview setHidden:TRUE];
    
    
    
    
    
    
    
    [self.asyncImageVw.layer setCornerRadius:54.0f];
    
    
    [self.asyncImageVw setUserInteractionEnabled:TRUE];
    
    [self.asyncImageVw setClipsToBounds:TRUE];
    [self.asyncImageVw.layer setBorderWidth:5.0f];
    [self.asyncImageVw.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
    
    UIActivityIndicatorView* mySpinner=mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    mySpinner.center = CGPointMake(_asyncImageVw.frame.size.width/2, _asyncImageVw.frame.size.height/2);
    
    [_asyncImageVw addSubview:mySpinner];
    
    [_asyncImageVw sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:profimageURL,[[respodict objectForKey:@"res" ] objectForKey:@"userimage" ]]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [mySpinner removeFromSuperview];
    }];
    [_asyncCountyvw sd_setImageWithURL:[NSURL URLWithString:[[respodict objectForKey:@"res" ] objectForKey:@"flag" ]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [mySpinner removeFromSuperview];
    }];
    
    // Do any additional setup after loading the view from its nib.
}


-(NSAttributedString *)chngetomulticolor: (NSString *)tempstring
{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:tempstring];
    NSRange range = [tempstring rangeOfString:@":"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,range.location+1)];
    return string;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_lbl_age_gender adjustsFontSizeToFitWidth];
    
    
    
    [_asyncCountyvw .layer setCornerRadius:_asyncCountyvw.frame.size.width/2];
    [_asyncCountyvw setClipsToBounds:YES];
    [_asyncCountyvw.layer setBorderWidth:1.0f];
    [_asyncCountyvw.layer setBorderColor:[[UIColor whiteColor]CGColor]];
    
    [_collection_home reloadData];
    
    
}

-(void)panGestureRecognized :(UIGestureRecognizer*)tapper
{
    NSLog(@"jkjkjkjk");
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



#pragma mark - UITableView Action Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [[[respodict objectForKey:@"res" ] objectForKey:@"posts" ] count];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *textstring=[NSString stringWithFormat:@"%@:%@",[[respodict objectForKey:@"res" ] objectForKey:@"username"],[[[[respodict objectForKey:@"res" ] objectForKey:@"posts" ] objectAtIndex:indexPath.section]objectForKey:@"status_text"]];
    
    
    
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f]};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect rect = [textstring boundingRectWithSize:CGSizeMake(tableView.frame.size.width-60, 2000)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];
    
    
    
    CGSize textSize = rect.size;
    
    //    CGSize   textSize = [textstring
    //                         sizeWithFont:[UIFont boldSystemFontOfSize:14]
    //                         constrainedToSize:CGSizeMake(tableView.frame.size.width-60, 2000)
    //                         lineBreakMode:NSLineBreakByWordWrapping];
    
    NSString *IMAGENAMEURL=[[[[respodict objectForKey:@"res" ] objectForKey:@"posts" ]objectAtIndex:indexPath.section]objectForKey:@"post_image" ];
    
    if(textSize.height<55.0f && [IMAGENAMEURL length]<4)
        
    {
        return 80.0f;
    }
    else if(textSize.height<45.0f && [IMAGENAMEURL length]>4){
        return 210.0f;
    }
    else if(textSize.height>45.0f && [IMAGENAMEURL length]>4){
        return textSize.height+50.0f+130.0f;
    }
    else{
        return textSize.height+70.0f;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
homeTableViewCell *cell;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *CellIdentifier =[NSString stringWithFormat:@"%li",(long)indexPath.section];
    cell = (homeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *textstring=[NSString stringWithFormat:@"%@:%@",[[respodict objectForKey:@"res" ] objectForKey:@"username"],[[[[respodict objectForKey:@"res" ] objectForKey:@"posts" ] objectAtIndex:indexPath.section]objectForKey:@"status_text"]];
    //    [cell.lblPost setText:textstring];
    //
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:textstring];
    NSRange range = [textstring rangeOfString:@":"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,range.location+1)];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f]};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect rect = [textstring boundingRectWithSize:CGSizeMake(tableView.frame.size.width-60, 2000)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];
    
    
    
    CGSize textSize = rect.size;
    
    
    //    CGSize   textSize = [textstring
    //                         sizeWithFont:[UIFont boldSystemFontOfSize:14]
    //                         constrainedToSize:CGSizeMake(tableView.frame.size.width-60, 2000)
    //                         lineBreakMode:NSLineBreakByWordWrapping];
    
    if (cell == nil)
    {
        cell = [[homeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier];
        
        cell.layer.cornerRadius=10.0f;
        [cell setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:10.f]];
        
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        
        
        
    }
    
    
    if([[[[[respodict objectForKey:@"res" ] objectForKey:@"posts" ] objectAtIndex:indexPath.section]objectForKey:@"post_image"]length  ]>4)
    {
        
        
        NSString *imageurl=[NSString stringWithFormat:@"http://108.179.196.157/~pallyapp/dev/ws/post_image/%@",[[[[respodict objectForKey:@"res" ] objectForKey:@"posts" ] objectAtIndex:indexPath.section]objectForKey:@"post_image"]];
        //        // NSLog(@"%@",imageurl);
        [cell.asyncPostImageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            
        }];
    }
    else{
        
        [cell.asyncPostImageView setHidden:TRUE];
        
    }
    
    
    if(textSize.height>55)
    {
        
        [cell.lblPost setFrame:CGRectMake(60, 6, textSize.width, textSize.height)];
        
        //        [cell.asyncPostImageView setFrame:CGRectMake(cell.asyncPostImageView.frame.origin.x, textSize.height+25.0f, cell.asyncPostImageView.frame.size.width, 120)];
        [cell.asyncPostImageView setFrame:CGRectMake(cell.frame.origin.x, 60, _tbl_main.frame.size.width, 150)];
        cell.asyncPostImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    else{
        //        [cell.asyncPostImageView setFrame:CGRectMake(cell.asyncPostImageView.frame.origin.x, 65.0f, cell.asyncPostImageView.frame.size.width, 120)];
        [cell.asyncPostImageView setFrame:CGRectMake(cell.frame.origin.x, 60, _tbl_main.frame.size.width, 150)];
        cell.asyncPostImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [cell.lblPost setFrame:CGRectMake(60, 6, textSize.width, 45)];
        [cell.lblPost setContentMode:UIViewContentModeCenter];
    }
    [cell.lblPost setAttributedText:string];
    
    NSString *imageurlprof=[NSString stringWithFormat:profimageURL,[[respodict objectForKey:@"res" ] objectForKey:@"userimage" ]];
    [cell.asyncProfileImageView sd_setImageWithURL:[NSURL URLWithString:imageurlprof] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        cell.asyncPostImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }];
    
    cell.asyncPostImageView.contentMode = UIViewContentModeScaleAspectFill;
    return cell;
}


#pragma mark - Button Action





- (IBAction)btnBlock_action:(id)sender
{
    NSDictionary *respdict= [[Singltonweblink createInstance]blockuser:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"] :_useidfrnd];
    //NSLog(@"%@",respdict);
    
    
    [self alertshow:1 :[[respdict objectForKey:@"response"] objectForKey:@"res"] :@""];
    
    
    
}
- (IBAction)BtnAdd_Action:(id)sender {
    
    
    
    if([[sender currentImage] isEqual:[UIImage imageNamed:@"add_friendg.png"]])
    {
        
        NSDictionary *respdict= [[Singltonweblink createInstance]SendFrendRequst:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"] :_useidfrnd];
        NSLog(@"%@",respdict);
        if([[[respdict objectForKey:@"response"] objectForKey:@"res"]isEqualToString:@"already requested"] || [[[respdict objectForKey:@"response"] objectForKey:@"res"]isEqualToString:@"Request has been sent"])
        {
            [self alertshow:1 :@"Request already sent" :@""];
        }
        
    }
    else if ([[sender currentImage] isEqual:[UIImage imageNamed:@"unfriend_button.png"]])
    {
        NSDictionary *respdict= [[Singltonweblink createInstance]unfrienduser:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"] :_useidfrnd];
        NSLog(@"%@",respdict);
    }
    else{
        [self alertshow:1 :@"Request already sent" :@""];
    }
}

- (IBAction)btnMessg_action:(id)sender {
    MessageVC *messagechartTVCOBJ;
    
    //    if([[UIScreen mainScreen]bounds].size.width==320)
    //    {
    //        messagechartTVCOBJ=[[MessageVC alloc]initWithNibName:@"MessageVC5" bundle:nil];
    //    }
    //    else{
    messagechartTVCOBJ =[[MessageVC alloc]initWithNibName:@"MessageVC" bundle:nil];
    //    }
    messagechartTVCOBJ.myimage=self.asyncImageVw.image;
    [self.navigationController pushViewController:messagechartTVCOBJ animated:YES];
}

- (IBAction)Menubtn_action:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnPhoto_action:(id)sender {
    
    [_tbl_main setHidden: TRUE];
    [_collection_home setHidden:FALSE];
    [backview setHidden:TRUE];
    [_bttn_photo setImage:[UIImage imageNamed:@"photos_buttonR.png"] forState:UIControlStateNormal];
    [_bttn_post setImage:[UIImage imageNamed:@"post_button2.png"] forState:UIControlStateNormal];
    [_bttb_about setImage:[UIImage imageNamed:@"About_us_button2.png"] forState:UIControlStateNormal];
    
    
    [self.tbl_main setHidden:TRUE];
    
}

- (IBAction)btnAbout_action:(id)sender {
    
    [_collection_home setHidden:TRUE];
    [backview setHidden:FALSE];
    
    [_bttn_photo setImage:[UIImage imageNamed:@"photos_button2.png"] forState:UIControlStateNormal];
    [_bttn_post setImage:[UIImage imageNamed:@"post_button2.png"] forState:UIControlStateNormal];
    [_bttb_about setImage:[UIImage imageNamed:@"about_buttonR.png"] forState:UIControlStateNormal];
    
    
    
    
    
    [self.tbl_main setHidden:TRUE];
}

- (IBAction)btnPost_Action:(id)sender {
    
    [backview setHidden:TRUE];
    [_collection_home setHidden:TRUE];
    [_bttn_photo setImage:[UIImage imageNamed:@"photos_button2.png"] forState:UIControlStateNormal];
    [_bttn_post setImage:[UIImage imageNamed:@"post_buttonR.png"] forState:UIControlStateNormal];
    [_bttb_about setImage:[UIImage imageNamed:@"About_us_button2.png"] forState:UIControlStateNormal];
    
    [self.tbl_main setHidden:FALSE];
}


#pragma mark - Alert Action

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



#pragma mark - Collectionview Delegate

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    //    return [[[respodict objectForKey:@"res" ] objectForKey:@"userPhotoPostDetail" ]count];
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [[[respodict objectForKey:@"res" ] objectForKey:@"userPhotoPostDetail" ]count];
    //        return 3;
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    UIView * contents=[[UIView alloc] initWithFrame:cell.contentView.bounds];
    [contents setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:contents];
    
    
    UIImageView *imgback=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,cell.frame.size.width, cell.frame.size.height)];
    [imgback setBackgroundColor:[UIColor redColor]];
    if([[[[[respodict objectForKey:@"res" ] objectForKey:@"userPhotoPostDetail" ] objectAtIndex:indexPath.row]objectForKey:@"post_image" ] length]==0)
    {
        [imgback setImage:[UIImage imageNamed:@"defaultimg.png"]];
    }
    else{
        
        NSString *strProf=[NSString stringWithFormat:@"http://108.179.196.157/~pallyapp/dev/ws/post_image/%@",[[[[respodict objectForKey:@"res" ] objectForKey:@"userPhotoPostDetail" ] objectAtIndex:indexPath.row]objectForKey:@"post_image" ]] ;
        
        NSLog(@"%@",strProf);
        [imgback sd_setImageWithURL:[NSURL URLWithString:strProf] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType,NSURL *imageurl){
            
        }];
        
    }
    imgback.contentMode = UIViewContentModeScaleAspectFill;
    
    [contents addSubview:imgback];
    
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([[UIScreen mainScreen]bounds].size.width/4/*/3-11*/, [[UIScreen mainScreen]bounds].size.width/4/*3-11*/);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

@end
