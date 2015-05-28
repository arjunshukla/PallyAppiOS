//
//  SignUPVC.m
//  TestApp
//
//  Created by Karanbeer Singh on 11/18/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "SignUPVC.h"
#import <QuartzCore/QuartzCore.h>

#import "Singltonweblink.h"


#import "SCLAlertView.h"

@interface SignUPVC ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>
{
    NSArray *_pickerData;
    UIPickerView *pickerView;
}
@property (weak, nonatomic) IBOutlet UITextField *tf_Uname;
@property (weak, nonatomic) IBOutlet UITextField *tf_email;
@property (weak, nonatomic) IBOutlet UITextField *tf_passwrd;
@property (weak, nonatomic) IBOutlet UITextField *tf_bday;
@property (weak, nonatomic) IBOutlet UITextField *tf_sex;
@property (weak, nonatomic) IBOutlet UITextField *tf_city;
@property (weak, nonatomic) IBOutlet UITextField *tf_country;
@property (weak, nonatomic) IBOutlet UITextField *tf_timezone;
@property (weak, nonatomic) IBOutlet UIImageView *imgvw_profile;
- (IBAction)btnsubmit_action:(id)sender;

@end

@implementation SignUPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:FALSE];
    self.title=@"Sign Up";
    // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BG.png"]]];
    _pickerData=[[NSArray alloc]initWithObjects:@"Male",@"Female", nil];
    [self.imgvw_profile.layer setCornerRadius:54.0f];
    
    [self.imgvw_profile setClipsToBounds:TRUE];
    [self.imgvw_profile.layer setBorderWidth:5.0f];
    [self.imgvw_profile.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
    
    
     CGRect pickerFrame = CGRectMake(0, 40, self.view.frame.size.width,100);
   pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    

    // Do any additional setup after loading the view from its nib.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if([textField.text isEqualToString:@"Email"] ||[textField.text isEqualToString:@"Password"])
    {
        [textField setText:@""];
    }
    
    if( self.view.frame.origin.y==0)
    {
       [self.view setFrame: CGRectMake(0, self.view.frame.origin.y-170, self.view.frame.size.width, self.view.frame.size.height)];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
        if(self.view.frame.origin.y<0)
        {
         [self.view setFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        }
    
    return [textField resignFirstResponder];
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

- (IBAction)btnsubmit_action:(id)sender {

    
    
    
    
    
    
    
    
    if(self.tf_email.text.length==0||self.tf_passwrd.text.length==0 ||self.self.tf_country.text.length==0)
    { [self alertshow :1 :@"Sorry!" :@"Fill the empty fields"];
    }
    else if(![self.tf_passwrd.text isEqualToString:self.tf_country.text])
    {
         [self alertshow :1 :@"Sorry!" :@"password don't matching"];
    }
    else if (![self validEmail:self.tf_email.text])
    {
         [self alertshow :1 :@"Sorry!" :@"Email is not valid"];
    }
    else{
       NSDictionary *respDict= [[Singltonweblink createInstance]Signup:self.tf_email.text :self.tf_passwrd.text ];
        if([[[respDict objectForKey:@"response"] objectForKey:@"res"] intValue]!=-1)
        {
             [self alertshow :1 :@"Welcome to Pally" :@"You’re set to go!"];
            [self.navigationController popViewControllerAnimated:TRUE];
        }
        else{
           [self alertshow :1 :@"Sorry !" :@"Email already exist "]; 
        }
    }
}


- (BOOL) validEmail:(NSString*) emailString {
    
    if([emailString length]==0){
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
    
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
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


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_pickerData objectAtIndex:row];
}
@end
