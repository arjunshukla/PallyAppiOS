//
//  MessageVC.m
//  TestApp
//
//  Created by Karanbeer Singh on 12/14/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "MessageVC.h"
#import "STBubbleTableViewCell.h"
#import "DEMONavigationController.h"
#import "Message.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Singltonweblink.h"
#import <AVFoundation/AVFoundation.h>

@interface MessageVC ()<STBubbleTableViewCellDataSource, STBubbleTableViewCellDelegate,UITableViewDelegate,UITextFieldDelegate,AVAudioRecorderDelegate,AVAudioSessionDelegate,AVAudioPlayerDelegate,UIGestureRecognizerDelegate>
{
    NSArray *respoarry;
    
    AVAudioRecorder *recorder;
    
    UIButton *bttn_record;
    UIButton *bttn_send2;
    
    AVAudioPlayer  *player;
}

@property(nonatomic,weak)IBOutlet UIView *tolbr_bottom;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bttn_sendmessage;
//@property (strong, nonatomic)  UIToolbar *tolbr_bottom;
@property (strong, nonatomic) IBOutlet UITextField *tf_typingmessage;
@property (nonatomic, strong) NSMutableArray *messages;


@property (nonatomic, weak)IBOutlet UITableView *tableView;
@property (nonatomic, weak)IBOutlet UITableView *tableView_image;

-(IBAction)bttnsend_Action:(id)sender;
-(IBAction)recordingstart:(id)sender;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fetchmesg)
                                                 name:@"TestNotification"
                                               object:nil];
    
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    [button setImage:[UIImage imageNamed:@"Menu.png"] forState:UIControlStateNormal];
    [button addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    self.title=self.usefrndname;
    
      self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
   // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
   // NSLog(@"%@",_dictData);
     [_tableView_image reloadData];
    
//    _tf_typingmessage=[[UITextField alloc]initWithFrame:CGRectMake(45, 2, self.view.frame.size.width-115, 40)];
//    [_tf_typingmessage setTextColor:[UIColor blackColor]];
//    [_tf_typingmessage.layer setCornerRadius:5];
//    [_tf_typingmessage setDelegate:self];
//    [_tf_typingmessage becomeFirstResponder];
//    [_tf_typingmessage.layer setBorderWidth:2];
//    [_tf_typingmessage setBackgroundColor:[UIColor whiteColor]];
//    [_tf_typingmessage.layer setBorderColor:(__bridge CGColorRef)([UIColor lightGrayColor])];
//    _tf_typingmessage.clipsToBounds=YES;
    
    
    
  //  UIBarButtonItem *OButton_rec;
  //  OButton_rec =[[UIBarButtonItem alloc]initWithCustomView:bttn_record];
    
    
    
 //   UIBarButtonItem *OButton_send;
  //  OButton_send =[[UIBarButtonItem alloc]initWithCustomView:bttn_send2];
    
    
   // UIBarButtonItem *OButton_sting;
  //  OButton_sting =[[UIBarButtonItem alloc]initWithCustomView:_tf_typingmessage];
    
   // NSArray *items = [NSArray arrayWithObjects:OButton_rec,OButton_sting,OButton_send,nil];
   // _tolbr_bottom.translucent=NO;
   // [_tolbr_bottom setItems:items animated:NO];
    //[self.view addSubview:_tolbr_bottom];
    

    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:nil];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];

    
    
    
    // Do any additional setup after loading the view from its nib.
}


-(IBAction)recordingstart:(id)sender
{
     [bttn_send2 setEnabled:FALSE];
    [_tf_typingmessage setText:@"Recording Starts"];
   // NSError *error;
 
    
    
    if([bttn_record.currentImage isEqual:[UIImage imageNamed:@"rec_icon.png"]])
    {
        [bttn_record setImage:[UIImage imageNamed:@"stop_icon.png"] forState:UIControlStateNormal];
    if (!recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [recorder record];
        
        
    } else {
        
        // Pause recording
        [recorder pause];
        
    }
    }
    else{
        [recorder stop];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
    }
}
- (IBAction)stopTapped:(id)sender {
    [recorder stop];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}


- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
  


    
    [bttn_record setImage:[UIImage imageNamed:@"rec_icon.png"] forState:UIControlStateNormal];
    
    [_tf_typingmessage setText:@""];
    
    [bttn_send2 setEnabled:TRUE];

}

-(void)bttnsend_Action :(id)sender
{
    
    if(_tf_typingmessage.text.length>0)
    {
        recorder=nil;
    }
    
    
    NSData *file1Data = [[NSData alloc] initWithContentsOfURL:recorder.url];
    
    
    
    
    NSDictionary *dict=  [[Singltonweblink createInstance]sendMessage:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"] :_useidfrnd :_tf_typingmessage.text : file1Data];
    
    NSLog(@"%@",dict);
    if([[[dict objectForKey:@"response"] objectForKey:@"message"]isEqualToString:@"Message has been sent successfully"])
    {
        [_tf_typingmessage resignFirstResponder];
        [self fetchmesg];
       // [self.messages addObject: [Message messageWithString:_tf_typingmessage.text image:_myimage]];
        [self.tableView reloadData];
        // [self.tableView setContentOffset:CGPointMake(self.tableView.frame.origin.x, self.tableView.contentSize.height-self.tableView.frame.size.height) animated:YES];
    }
    
    
    [self.tolbr_bottom setFrame:CGRectMake(_tolbr_bottom.frame.origin.x,self.view.frame.size.height-_tolbr_bottom.frame.size.height, _tolbr_bottom.frame.size.width, _tolbr_bottom.frame.size.height)];
    [_tf_typingmessage setText:@""];
}
- (void)fetchmesg
{
    
    NSLog(@"%@",_useidfrnd);
    NSDictionary *dict=  [[Singltonweblink createInstance]FetchMessage:[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"] :_useidfrnd];
    
    NSLog(@"%@",dict);
if([[dict objectForKey:@"response"] count]>0)
{
    respoarry=[[NSArray alloc]initWithArray:[dict objectForKey:@"response"]];
    self.messages = [[NSMutableArray alloc] init ];
    for(int i=0;i<[respoarry count];i++)
    {
        [self.messages addObject:[Message messageWithString:[[respoarry objectAtIndex:i] objectForKey:@"text"] image:_myimage]];
    }
    
    [self.tableView reloadData];
    
    
    [self.tableView setContentOffset:CGPointMake(self.tableView.frame.origin.x, self.tableView.contentSize.height-self.tableView.frame.size.height+100) animated:YES];
}
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchmesg];
    [_tableView reloadData];
   // NSLog(@"tablevw   %@",self.dictData);
    
    

   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
       NSLog(@"%f",_tolbr_bottom.frame.origin.y-244);
    
    if(self.tolbr_bottom.frame.origin.y==self.view.frame.size.height-self.tolbr_bottom.frame.size.height)
        {
            [UIView animateWithDuration:0.27f animations:^{
               [self.tolbr_bottom setFrame:CGRectMake(_tolbr_bottom.frame.origin.x,_tolbr_bottom.frame.origin.y-254, _tolbr_bottom.frame.size.width, _tolbr_bottom.frame.size.height)];
            }];
           
        }
    NSLog(@"%f",_tolbr_bottom.frame.origin.y);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
     [UIView animateWithDuration:0.27f animations:^{
   [self.tolbr_bottom setFrame:CGRectMake(_tolbr_bottom.frame.origin.x,self.view.frame.size.height-self.tolbr_bottom.frame.size.height, _tolbr_bottom.frame.size.width, _tolbr_bottom.frame.size.height)];
         }];
    return [textField resignFirstResponder];
}









#pragma mark - UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==0)
    {
    return [self.messages count];
    }
    else{
        return [_dictData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Bubble Cell";
    
    
    if(tableView.tag==0)
    {
    
    STBubbleTableViewCell *cell = (STBubbleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[STBubbleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = self.tableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataSource = self;
        cell.delegate = self;
        
        
        
        
    }
    
    Message *message = [self.messages objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    
    
    UIButton *btn_Rec=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Rec setFrame:CGRectMake(50, 5, 50, 50)];
    [btn_Rec setImage:[UIImage imageNamed:@"play_icon.png"] forState:UIControlStateNormal];
    [btn_Rec setTag:indexPath.row];
    
    [btn_Rec addTarget:self action:@selector(btnrecPlay:) forControlEvents:UIControlEventTouchUpInside];
    [cell.recView addSubview:btn_Rec];
    
    
    
    
    
    if([[[respoarry objectAtIndex:indexPath.row] objectForKey:@"voice_document"] length]>0)
    {
        [cell.textLabel setHidden:TRUE];
        [cell.bubbleView setHidden:TRUE];
        [cell.recView setHidden:FALSE];
    }
    else{
       [cell.textLabel setHidden:FALSE];
        [cell.bubbleView setHidden:FALSE];
        [cell.recView setHidden:TRUE];
    }
    
    cell.textLabel.text = message.message;
    
    cell.imageView.image = message.avatar;
    
    // Put your own logic here to determine the author
    if([[[respoarry objectAtIndex:indexPath.row] objectForKey:@"send_by"] intValue]==[[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"] intValue])
    {
        cell.authorType = STBubbleTableViewCellAuthorTypeSelf;
        cell.bubbleColor = STBubbleTableViewCellBubbleColorGreen;
        [cell.recView setFrame:CGRectMake(10, cell.recView.frame.origin.y, 200, 60)];
    }
    else
    {
        cell.authorType = STBubbleTableViewCellAuthorTypeOther;
        cell.bubbleColor = STBubbleTableViewCellBubbleColorOrange;
        [cell.recView setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width-210, cell.recView.frame.origin.y, 200, 60)];
    }
    
    return cell;
    }
    else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UIImageView *img_frnd=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 56, 56)];
        [img_frnd.layer setCornerRadius:28.0f];
        
        [img_frnd setClipsToBounds:TRUE];
        [img_frnd.layer setBorderWidth:1.0f];
        [img_frnd.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
        UIActivityIndicatorView* mySpinner=mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        mySpinner.center = CGPointMake(img_frnd.frame.size.width/2, img_frnd.frame.size.height/2);
        
        [img_frnd addSubview:mySpinner];
        // [img_frnd setImage:[UIImage imageNamed:@"img01.jpg"]];
        [img_frnd sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:profimageURL,[[_dictData objectAtIndex:indexPath.row ]objectForKey:@"userimage"]]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            [mySpinner removeFromSuperview];
        }];
        [img_frnd setTag:[[[_dictData objectAtIndex:indexPath.row] objectForKey:@"id"] intValue]];
        [cell addSubview:img_frnd];
        [img_frnd setUserInteractionEnabled:TRUE];
        [img_frnd addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        return cell;
    }
}
-(void)btnrecPlay: (id)sender
{
    
    if([[sender currentImage] isEqual:[UIImage imageNamed:@"play_icon.png"]])
    {
        [sender setImage:[UIImage imageNamed:@"stop_icon.png"] forState:UIControlStateNormal];
    NSString *myString = [[respoarry objectAtIndex:[sender tag]] objectForKey:@"voice_document"];
    
    NSLog(@"%@",myString);
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
    [player setDelegate:self];
    [player play];
    }
    else{
       [sender setImage:[UIImage imageNamed:@"play_icon.png"] forState:UIControlStateNormal];
        [player stop];
    }

}

#pragma mark - AVAudioPlayerDelegate

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
   // UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Done"
    //                                                message: @"Finish playing the recording!"
    ////                                               delegate: nil
     //                                     cancelButtonTitle:@"OK"
     //                                     otherButtonTitles:nil];
   // [alert show];
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView.tag==0)
    {
    Message *message = [self.messages objectAtIndex:indexPath.row];
    
    CGSize size;
    
    if(message.avatar)
    {
        size = [[Singltonweblink createInstance]textsizer:message.message :CGSizeMake(self.tableView.frame.size.width - [self minInsetForCell:nil atIndexPath:indexPath] - STBubbleImageSize - 8.0f - STBubbleWidthOffset, CGFLOAT_MAX)];
//        size = [message.message sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(self.tableView.frame.size.width - [self minInsetForCell:nil atIndexPath:indexPath] - STBubbleImageSize - 8.0f - STBubbleWidthOffset, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        
        size = [[Singltonweblink createInstance]textsizer:message.message :CGSizeMake(self.tableView.frame.size.width - [self minInsetForCell:nil atIndexPath:indexPath] - STBubbleWidthOffset, CGFLOAT_MAX)];
       // size = [message.message sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(self.tableView.frame.size.width - [self minInsetForCell:nil atIndexPath:indexPath] - STBubbleWidthOffset, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    // This makes sure the cell is big enough to hold the avatar
    
    if([[[respoarry objectAtIndex:indexPath.row] objectForKey:@"voice_document"] length]>0)
    {
    return 70.0f;
    }
    else{
        if(size.height + 15.0f < STBubbleImageSize + 4.0f && message.avatar)
        {
            return STBubbleImageSize + 4.0f;
        }
        
        return size.height + 15.0f;
        
    }
    }
    else{
        return 60.0f;
    }
}

#pragma mark - STBubbleTableViewCellDataSource methods

- (CGFloat)minInsetForCell:(STBubbleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 50.0f;
}

#pragma mark - STBubbleTableViewCellDelegate methods

- (void)tappedImageOfCell:(STBubbleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Message *message = [self.messages objectAtIndex:indexPath.row];
    NSLog(@"%@", message.message);
}






-(void)panGestureRecognized :(UIGestureRecognizer*)tapper
{
    UIImageView *imgv=(UIImageView *)tapper.view;
    self.useidfrnd=[NSString stringWithFormat:@"%li",(long)imgv.tag];
    [self fetchmesg];
    
    
    // NSLog(@"jkjkjkjk %@",_main_arry  );
    
//    FriendProfileVC *friendProfileVCOBJ=[[FriendProfileVC alloc]init];
//    friendProfileVCOBJ.useidfrnd=[[_main_arry objectAtIndex:0] objectForKey:@"id"];
//    [self.navigationController pushViewController:friendProfileVCOBJ animated:YES];
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
