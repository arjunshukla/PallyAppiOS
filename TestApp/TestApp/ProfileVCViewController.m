//
//  ProfileVCViewController.m
//  TestApp
//
//  Created by Karanbeer Singh on 11/20/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "ProfileVCViewController.h"
#import "DEMONavigationController.h"
#import "Singltonweblink.h"

#import "SDWebImage/UIImageView+WebCache.h"
#import "SCLAlertView.h"
#import "MBProgressHUD.h"

@interface ProfileVCViewController ()<UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate>
{
   
    UIView *vedatepiker;
    
    NSString *gender;
    
    NSData *imageData;
    
    
    UILabel *lbl_info;
    
    NSArray *city_arry;
      NSArray *languge_arry;;
    
    UITextField *temptextfield;
    
    UIActivityIndicatorView* mySpinner;
    NSString *string_category;
    
    NSDictionary *response;
    
    
    NSArray *arry_tblmain;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tblmain;
@property (weak, nonatomic) IBOutlet UIButton *btn_tabl_end;
@property (weak, nonatomic) IBOutlet UISearchBar *serch_tblmain;
@property (weak, nonatomic) IBOutlet UIView *view_main;

@property (weak, nonatomic) IBOutlet UIButton *btn_male;
@property (weak, nonatomic) IBOutlet UIButton *btn_female;
@property (weak, nonatomic) IBOutlet UIButton *btn_secret;


@property (weak, nonatomic) IBOutlet UISegmentedControl *sgcnt_gender;
@property (weak, nonatomic) IBOutlet UIView *country_Picker;
@property (weak, nonatomic) IBOutlet UIButton *btn_BrthdY;;
@property (weak, nonatomic) IBOutlet UITextField *tf_sex;
@property (weak, nonatomic) IBOutlet UITextField *tf_city;
@property (weak, nonatomic) IBOutlet UIButton *btn_country;
@property (weak, nonatomic) IBOutlet UITextField *tf_timezone;
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextView *tv_descr;
@property (weak, nonatomic) IBOutlet UITextField *tf_language;
@property (weak, nonatomic) IBOutlet UITextField *tf_language2;
@property (weak, nonatomic) IBOutlet UITextField *tf_language3;

@property (weak, nonatomic) IBOutlet UIButton *btn_City;
@property (weak, nonatomic)  UIPickerView *picker;
- (IBAction)btnCity_action:(id)sender;

- (IBAction)segment_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgvw_profile;
@property (weak, nonatomic) IBOutlet UIImageView *asyncImageVw;

- (IBAction)createActionSheet1:(id)sender;

@end

@implementation ProfileVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"Profile";
    
    city_arry=[[NSArray alloc]init];
    arry_tblmain=[[NSArray alloc]init];
    
    
    languge_arry=[[NSArray alloc]initWithArray:[Singltonweblink LanguageArraY]];
    
    
    
    
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    [button setImage:[UIImage imageNamed:@"cancel_icon.png"] forState:UIControlStateNormal];
    [button addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *buttontick = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    [buttontick setImage:[UIImage imageNamed:@"done_icon.png"] forState:UIControlStateNormal];
    [buttontick addTarget:self action:@selector(tickbttn_action) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.title=@"Profile";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttontick];

    
    
  //  [self Viewpicker_bacvkground];
    [self.asyncImageVw.layer setCornerRadius:self.asyncImageVw.frame.size.width/2];
    
    //[_asyncImageVw setContentMode:UIViewContentModeScaleAspectFit];
    [self.asyncImageVw setUserInteractionEnabled:TRUE];
    
    [self.asyncImageVw setClipsToBounds:TRUE];
    [self.asyncImageVw.layer setBorderWidth:5.0f];
    [self.asyncImageVw.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
    
     //[self.imgvw_profile addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
    
    [self.asyncImageVw  addGestureRecognizer:tapgesture];
    
    mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    mySpinner.center = CGPointMake(self.asyncImageVw.frame.size.width/2, self.asyncImageVw.frame.size.height/2);
    
    [self.asyncImageVw addSubview:mySpinner];
 
    
   // response=[[NSUserDefaults standardUserDefaults]objectForKey:@"cityarry"];
    response=[[Singltonweblink createInstance]cityname];
    
    [self.tv_descr.layer setCornerRadius:10.0f];
    [self.tv_descr setClipsToBounds:TRUE];
    [self.tv_descr.layer setBorderWidth:1.0f];
    [self.tv_descr setBackgroundColor:[UIColor whiteColor]];
    
    NSDictionary *responderdic=[[Singltonweblink createInstance]GetProfile:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId" ]]];
     // NSLog(@"%@",responderdic);
    [self fillprofiledata:responderdic];
}

-(void)tickbttn_action
{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    imageData=UIImageJPEGRepresentation(self.asyncImageVw.image, 0.3f);
    
    [self performSelector:@selector(update_profile) withObject:self afterDelay:0.2f];
}
-(void)Viewpicker_bacvkground

{
    [_view_main setFrame: CGRectMake(0, 0, _view_main.frame.size.width, _view_main.frame.size.height)];
    if(vedatepiker)
    {
       
        [vedatepiker removeFromSuperview];
    }
    
    vedatepiker=[[UIView alloc]initWithFrame:CGRectMake(0,_view_main.frame.size.height/3, self.view.frame.size.width , 350)];
   // [vedatepiker setBackgroundColor:[UIColor  colorWithRed:0.1804 green:0.6510 blue:0.50569 alpha:0.9f]];
    [vedatepiker setBackgroundColor: [UIColor whiteColor]];
    [_view_main addSubview:vedatepiker];
    
    
    
    lbl_info=[[UILabel alloc]initWithFrame:CGRectMake(10, 10,self.view.frame.size.width-100, 20)];
    //[lbl_info setText:@"Select your Birthdate..."];
    [lbl_info setTextColor:[UIColor lightGrayColor]];
    [vedatepiker addSubview: lbl_info];
    
    
//   UILabel *lbl_month=[[UILabel alloc]initWithFrame:CGRectMake(80, 30,50, 20)];
//    [lbl_month setText:@"Month"];
//    [lbl_month setTextColor:[UIColor lightGrayColor]];
//    [vedatepiker addSubview: lbl_month];
//    
//    
//    UILabel *lbl_date=[[UILabel alloc]initWithFrame:CGRectMake(200, 30,50, 20)];
//    [lbl_date setText:@"Date"];
//    [lbl_date setTextColor:[UIColor lightGrayColor]];
//    [vedatepiker addSubview: lbl_date];
//    
//    UILabel *lbl_year=[[UILabel alloc]initWithFrame:CGRectMake(260, 30,50, 20)];
//    [lbl_year setText:@"Year"];
//    [lbl_year setTextColor:[UIColor lightGrayColor]];
//    [vedatepiker addSubview: lbl_year];
    
    UIButton *bttn_done=[UIButton buttonWithType:UIButtonTypeCustom];
    [bttn_done setFrame:CGRectMake(self.view.frame.size.width/2-30, 270, 70, 40)];
   // [bttn_done setTitle:@"ok_button.png" forState:UIControlStateNormal];
    [bttn_done setImage:[UIImage imageNamed:@"ok_button.png"] forState:UIControlStateNormal];
    //[bttn_done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bttn_done addTarget:self action:@selector(donedatePiker_action:) forControlEvents:UIControlEventTouchUpInside];
    [vedatepiker addSubview:bttn_done];

}







     -(void)fillprofiledata :(NSDictionary *)responsived
     {
         self.tf_city.text=[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"city" ];
         
         [self.btn_City setTitle:[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"city" ] forState:UIControlStateNormal];
         self.tf_name.text=[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"username" ];
         if([[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"dob" ]length ]>0)
         {
         [self.btn_BrthdY setTitle:[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"dob" ] forState:UIControlStateNormal];
         }
         if([[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"country" ]length ]>0)
         {
         [self.btn_country setTitle:[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"country" ] forState:UIControlStateNormal];
             
             
             
           //  city_arry= [response objectForKey:[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"country" ]];
             city_arry = [[NSSet setWithArray:[response objectForKey:[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"country" ]]] allObjects];
             city_arry = [city_arry sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
         }
         [self.tv_descr setText:[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"description" ]];
         
         [self.tf_language setText:[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"language" ]];
         [self.tf_language adjustsFontSizeToFitWidth];
         [self.tf_language setMinimumFontSize:11];
         [self.tf_language2 setText:[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"language2" ]];
         [self.tf_language3 setText:[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"language3" ]];
        
         NSString *imageUrl=[NSString stringWithFormat:profimageURL,[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"userimage" ]];
        // [self.asyncImageVw setImageURL:[NSURL URLWithString:imageUrl]];
         [self.asyncImageVw sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            [ mySpinner removeFromSuperview];
         }];
         
         
         if([[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"gender" ] isEqualToString:@"Male"])
         {
             [_btn_male setBackgroundImage:[UIImage imageNamed:@"male_mark_.png"] forState:UIControlStateNormal];
             [_btn_female setBackgroundImage:[UIImage imageNamed:@"female_without_mark_.png"] forState:UIControlStateNormal];
             [_btn_secret setBackgroundImage:[UIImage imageNamed:@"secret_without_mark_.png"] forState:UIControlStateNormal];
             gender=@"Male";
         }
         else if([[[[responsived objectForKey:@"response"]objectForKey:@"res" ]objectForKey:@"gender" ] isEqualToString:@"Female"]){
             [_btn_male setBackgroundImage:[UIImage imageNamed:@"male_without_mark_.png"] forState:UIControlStateNormal];
             [_btn_female setBackgroundImage:[UIImage imageNamed:@"female_mark_.png"] forState:UIControlStateNormal];
             [_btn_secret setBackgroundImage:[UIImage imageNamed:@"secret_without_mark_.png"] forState:UIControlStateNormal];
             gender=@"Female";
         }
         
         else{
             [_btn_male setBackgroundImage:[UIImage imageNamed:@"male_without_mark_.png"] forState:UIControlStateNormal];
             [_btn_female setBackgroundImage:[UIImage imageNamed:@"female_without_mark_.png"] forState:UIControlStateNormal];
             [_btn_secret setBackgroundImage:[UIImage imageNamed:@"secret_mark_.png"] forState:UIControlStateNormal];
             gender=@"Secret";
         }
         
         
         
         [self countryNames];
         
     }






#pragma mark - Country City List 


-(NSDictionary *)countryNamesByCode
{
    static NSDictionary *_countryNamesByCode = nil;
    if (!_countryNamesByCode)
    {
        NSMutableDictionary *namesByCode = [NSMutableDictionary dictionary];
        for (NSString *code in [NSLocale ISOCountryCodes])
        {
            NSString *countryName = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:code];
            
            //workaround for simulator bug
            if (!countryName)
            {
                countryName = [[NSLocale localeWithLocaleIdentifier:@"en_US"] displayNameForKey:NSLocaleCountryCode value:code];
            }
            
            namesByCode[code] = countryName ?: code;
        }
        _countryNamesByCode = [namesByCode copy];
    }
   
    return _countryNamesByCode;
}

- (NSArray *)countryNames
{
    static NSArray *_countryNames = nil;
    if (!_countryNames)
    {
        _countryNames = [[[[self countryNamesByCode] allValues] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] copy];
        
    }
   // NSLog(@"%@",_countryNames);
    return _countryNames;
}





#pragma mark - ImagePicker Action




-(void)panGestureRecognized :(UIGestureRecognizer*)tapper
{
 
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
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



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    self.asyncImageVw.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    imageData=UIImageJPEGRepresentation(self.asyncImageVw.image, 0.3f);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}





#pragma mark - TextField Delegates


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==9)
    {
        if(arry_tblmain==[self countryNames])
        {
            ary=[NSMutableArray arrayWithArray:[self countryNames]];
        }
        else if (arry_tblmain==city_arry)
        {
            ary=[city_arry mutableCopy];
        }
        else{
            ary=[languge_arry mutableCopy];
        }
       
        
        // Filter the array using NSPredicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",textField.text];
        arry_tblmain = [NSMutableArray arrayWithArray:[arry_tblmain filteredArrayUsingPredicate:predicate]];
       // arry_tblmain=ary;
        
        [_tblmain reloadData];
    }

}

NSMutableArray *languagearrytemp;
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  if(textField==_tf_language || textField==_tf_language2 || textField==_tf_language3)
  {
      temptextfield=textField;
      


      
  }
    
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.view setFrame:CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height)];

}
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
         [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [textView resignFirstResponder];
        return NO;
    }else{
               return YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
  
}


#pragma mark - All------Button-------Actions

-(IBAction)btnViewTablehide:(id)sender
{
   // [_view_main setHidden:TRUE];
    
    
    
    if(arry_tblmain==languge_arry)
    {
        if([languagearrytemp count]==1)
        {
            [_tf_language setText:[languagearrytemp objectAtIndex:0]];
        }
        if([languagearrytemp count]==2)
        {
            [_tf_language setText:[languagearrytemp objectAtIndex:0]];
            [_tf_language2 setText:[languagearrytemp objectAtIndex:1]];
        }
        if([languagearrytemp count]==3)
        {
            [_tf_language setText:[languagearrytemp objectAtIndex:0]];
            [_tf_language2 setText:[languagearrytemp objectAtIndex:1]];

            [_tf_language3 setText:[languagearrytemp objectAtIndex:2]];
        }
    }
    [_view_main setFrame: CGRectMake(0, _view_main.frame.size.height, _view_main.frame.size.width, _view_main.frame.size.height)];
}
- (IBAction)btncountry_action:(id)sender
{
    
    [vedatepiker setHidden:TRUE];
    [self.tblmain setHidden: FALSE];
    [_view_main setFrame: CGRectMake(0, 0, _view_main.frame.size.width, _view_main.frame.size.height)];
   // [self.view addSubview:_view_main];
    string_category=@"Country";
    arry_tblmain=[self countryNames];
    
    [_tblmain reloadData];
    
}
-(IBAction)btnlanguage_action:(id)sender {
    
    
    [vedatepiker setHidden:TRUE];
    [self.tblmain setHidden: FALSE];
    [_view_main setFrame: CGRectMake(0, 0, _view_main.frame.size.width, _view_main.frame.size.height)];
    //[self.view addSubview:_view_main];
    string_category=@"Language";
    languagearrytemp=[[NSMutableArray alloc]init];
    arry_tblmain=languge_arry;
    
    [_tblmain reloadData];
}

- (IBAction)btnCity_action:(id)sender {
    
    
    [vedatepiker setHidden:TRUE];
    [self.tblmain setHidden: FALSE];
    [_view_main setFrame: CGRectMake(0, 0, _view_main.frame.size.width, _view_main.frame.size.height)];
    //[self.view addSubview:_view_main];
    string_category=@"City";
    arry_tblmain=city_arry;
    
    [_tblmain reloadData];
    
    
    
    
    
}




-(void)update_profile
{
    
    
    if([_btn_City.titleLabel.text isEqualToString:@"City"])
    {
        [self alertshow :1 :@"" :@"Select your City"];
    }
    else if ([_btn_country.titleLabel.text isEqualToString:@"Country"])
    {[self alertshow :1 :@"" :@"Select your country"];
        
    }else if ([_btn_BrthdY.titleLabel.text isEqualToString:@"Birthday"])
    {
       [self alertshow :1 :@"" :@"Add your BirthDate"];
    }else if( _tf_language.text.length==0)
    {
     [self alertshow :1 :@"" :@"Add native language"];
    }else if ( gender.length==0 )
    {
      [self alertshow :1 :@"" :@"Select gender"];
    }else if (imageData.length==0)
    {
       [self alertshow :1 :@"" :@"Upload your profile Image"];
    }
    else{
    
    NSDictionary *responseDict=[[Singltonweblink createInstance]Updateprofile:self.tf_name.text :self.btn_BrthdY.titleLabel.text :gender :imageData :self.btn_country.titleLabel.text :_btn_City.titleLabel.text :self.tf_language.text :self.tv_descr.text :_tf_language2.text :_tf_language3.text];
   
    
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    
    if([[[responseDict objectForKey:@"response"]objectForKey:@"message" ] isEqualToString:@"profile updated successfully"])
    {
        [self alertshow :1 :@"" :@"Profile updated successfully"];
    }
        
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






- (IBAction)segment_Action:(id)sender {
    
    if([sender tag]==1)
    {
        [_btn_male setBackgroundImage:[UIImage imageNamed:@"male_mark_.png"] forState:UIControlStateNormal];
        [_btn_female setBackgroundImage:[UIImage imageNamed:@"female_without_mark_.png"] forState:UIControlStateNormal];
        [_btn_secret setBackgroundImage:[UIImage imageNamed:@"secret_without_mark_.png"] forState:UIControlStateNormal];
        gender=@"Male";
        
    }
    else if ([sender tag]==2)
    {
        [_btn_male setBackgroundImage:[UIImage imageNamed:@"male_without_mark_.png"] forState:UIControlStateNormal];
        [_btn_female setBackgroundImage:[UIImage imageNamed:@"female_mark_.png"] forState:UIControlStateNormal];
        [_btn_secret setBackgroundImage:[UIImage imageNamed:@"secret_without_mark_.png"] forState:UIControlStateNormal];
        gender=@"Female";
    }
    else{
        [_btn_male setBackgroundImage:[UIImage imageNamed:@"male_without_mark_.png"] forState:UIControlStateNormal];
        [_btn_female setBackgroundImage:[UIImage imageNamed:@"female_without_mark_.png"] forState:UIControlStateNormal];
        [_btn_secret setBackgroundImage:[UIImage imageNamed:@"secret_mark_.png"] forState:UIControlStateNormal];
        
        gender=@"All";
    }

}






#pragma mark - PickerView Delegates



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView.tag==1)
    {
    return [self countryNames].count;
    }
    else if(pickerView.tag==2){
        return city_arry.count;
    }
    else{
         return languge_arry.count;
    }
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag==1)
    {
    return [self countryNames][row];
    }
    else if(pickerView.tag==2){
        return [city_arry objectAtIndex:row];
    }
    else{
        return [languge_arry objectAtIndex:row];
    }

}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag==1)
    {
        
        
        
        
    [self.btn_country setTitle:[self countryNames][row] forState:UIControlStateNormal];
        city_arry= [response objectForKey:[self countryNames][row]];
         city_arry = [city_arry sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        city_arry=[[NSSet setWithArray:city_arry] allObjects];


    }
    else  if(pickerView.tag==2){
         [self.btn_City setTitle:city_arry[row] forState:UIControlStateNormal];
    }

else{
    [temptextfield  setText:languge_arry[row]];
}

}

UIActionSheet *actionSheet;
NSString *pickerType;






#pragma mark - DatePickerView Delegates



- (IBAction)createActionSheet1:(id)sender {
    
    
    
    
    
     [self Viewpicker_bacvkground];
    [vedatepiker setHidden:FALSE];
    [self.tblmain setHidden: TRUE];
    
    [UIView animateWithDuration:0.5f animations:^{
         [ vedatepiker setFrame:CGRectMake(0, self.view.frame.size.height/3, self.view.frame.size.width ,350)];
   
   [lbl_info setText:@"Choose Birth Date :"];
    
    
    
        
        // Add the picker
      UIDatePicker  *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 325, 200)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.hidden = NO;
        datePicker.date = [NSDate date];
    
        [datePicker addTarget:self
                       action:@selector(changeDateInLabel:)
             forControlEvents:UIControlEventValueChanged];
       // [self.view addSubview:datePicker];
        
        [vedatepiker addSubview:datePicker];
    } completion:^(BOOL finished) {
        // onComplete
        }];
    
}

-(void) donedatePiker_action :(id)sender
{
    
    [_view_main setFrame: CGRectMake(0, [[UIScreen mainScreen]bounds].size.height, _view_main.frame.size.width, _view_main.frame.size.height)];


}

- (void)changeDateInLabel:(id)sender{
    NSString *dob;
    
    
    UIDatePicker *datepicker=(UIDatePicker *)sender;
    //Use NSDateFormatter to write out the date in a friendly format
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    dob = [NSString stringWithFormat:@"%@",[df stringFromDate:datepicker.date]];
    NSLog(@"%@",dob);
    //self.btn_BrthdY.titleLabel.text=dob;
[self.btn_BrthdY setTitle:dob forState:UIControlStateNormal];
    
}



#pragma mark - SearchBAr methods
NSMutableArray *ary;
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//   }
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//   //[ary removeAllObjects];
//    if(arry_tblmain==[self countryNames])
//    {
//    ary=[[self countryNames] mutableCopy];
//    }
//    else if (arry_tblmain==city_arry)
//    {
//     ary=[city_arry mutableCopy];
//    }
//    else{
//        ary=[languge_arry mutableCopy];
//    }
//    
//    
//    // Filter the array using NSPredicate
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchBar.text];
//    arry_tblmain = [NSMutableArray arrayWithArray:[arry_tblmain filteredArrayUsingPredicate:predicate]];
//    //arry_tblmain=ary;
//    
//    [_tblmain reloadData];
//
//    
//}




#pragma mark - UITableViewDatasource methods


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footer=[[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,36)];
    footer.backgroundColor=[UIColor whiteColor];
    
    UILabel *lbltit=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width/2, 30)];
    [lbltit setText:string_category];
    [lbltit setFont: [UIFont boldSystemFontOfSize:16.0f]];
    [footer addSubview:lbltit];
    
    
   
    
    UITextField *tf=[[UITextField alloc]initWithFrame:CGRectMake(lbltit.frame.size.width+10,5, tableView.frame.size.width-lbltit.frame.size.width-15, 30)];
    [tf setDelegate:self];
    [tf setTag:9];
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    [footer addSubview:tf];

    UISearchBar *serchbartybl=[[UISearchBar alloc]init];
    [serchbartybl setFrame:CGRectMake(tableView.frame.size.width/2, 0, tableView.frame.size.width/2, 40)];
    
    [serchbartybl setDelegate: self];
    
    //[footer addSubview:serchbartybl];
    return footer;

}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //return  _btn_tabl_end;
    
    UIView *footer=[[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,36)];
    footer.backgroundColor=[UIColor whiteColor];
   
    
    UIButton *btnendtbl=[UIButton buttonWithType:UIButtonTypeCustom];
     [btnendtbl setFrame:CGRectMake(tableView.frame.size.width/2-50, 0, 100, 36)];
    [btnendtbl setImage:[UIImage imageNamed:@"ok_button.png"] forState:UIControlStateNormal];
    [btnendtbl addTarget:self action:@selector(btnViewTablehide:) forControlEvents:UIControlEventTouchUpInside];
   
    [footer addSubview:btnendtbl];
    return footer;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arry_tblmain count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString *CellIdentifier=[NSString stringWithFormat:@"%li",(long)indexPath];
    
    
    
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        
       
        
        
    }
    cell.backgroundColor = tableView.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     [cell.textLabel setText:[arry_tblmain objectAtIndex:indexPath.row]];
    
    
    
    
    
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    UITableViewCell *cell=(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f]];
    
    if([string_category isEqualToString:@"Country"])
    {
        if(![_btn_country.titleLabel.text isEqualToString:[arry_tblmain objectAtIndex:indexPath.row]])
        {
            [_btn_City setTitle:@"City" forState:UIControlStateNormal];
        }
        [_btn_country setTitle:[arry_tblmain objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        city_arry= [response objectForKey:[arry_tblmain objectAtIndex:indexPath.row]];
        
        city_arry=[[NSSet setWithArray:city_arry] allObjects];
        city_arry = [city_arry sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    else if ([string_category isEqualToString:@"City"])
    {
        [_btn_City setTitle:[arry_tblmain objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }
    else{
        //[_tf_language setText:[arry_tblmain objectAtIndex:indexPath.row]];
        [languagearrytemp addObject:[arry_tblmain objectAtIndex:indexPath.row]];
    }
   if(arry_tblmain==languge_arry)
   {
      if([languagearrytemp count]==3)
      {
           [self btnViewTablehide:self.btn_tabl_end];
      }
   }
   else{
        [self btnViewTablehide:self.btn_tabl_end];
   }

}

@end
