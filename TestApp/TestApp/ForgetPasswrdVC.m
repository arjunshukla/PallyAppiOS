//
//  ForgetPasswrdVC.m
//  TestApp
//
//  Created by Karanbeer Singh on 11/19/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "ForgetPasswrdVC.h"
#import "SCLAlertView.h"

#import "Singltonweblink.h"

@interface ForgetPasswrdVC ()<UIActionSheetDelegate>
{
     UIView *vedatepiker;
     UILabel *lbl_info;
}
@property (weak, nonatomic) IBOutlet UITextField *tf_email;
- (IBAction)bttnsendMail_action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_BrthdY;;
- (IBAction)createActionSheet1:(id)sender;
@end

@implementation ForgetPasswrdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:FALSE];
    // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BG.png"]]];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UITapGestureRecognizer *tapgestr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tapgestr];
    
}
-(void)viewTap
{
    if([_tf_email becomeFirstResponder])
    {
        [_tf_email resignFirstResponder];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField.text  isEqualToString:@"Your Email Address"])
    {
        textField.text=@"";
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.text.length==0)
    {
        textField.text=@"Your Email Address";
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

- (IBAction)bttnsendMail_action:(id)sender {
    if (self.tf_email.text.length==0 || [_tf_email.text isEqualToString:@"Your Email Address"]){
        [self alertshow :1 :@"Sorry!" :@"Fill you email please"]; 
    }
    else if (![self validEmail:self.tf_email.text])
    {
         [self alertshow :1 :@"Sorry!" :@"Email is not valid"];
    }
    else
    {
     NSDictionary *resopdict= [[Singltonweblink createInstance]ForegetPassword:self.tf_email.text :self.btn_BrthdY.titleLabel.text];
        
        NSLog(@"%@",resopdict);
        
         [self alertshow :1 :@"" :[[resopdict objectForKey:@"response"] objectForKey:@"message"]];
    }
}


-(void)Viewpicker_bacvkground

{
    if(vedatepiker)
    {
        [self donedatePiker_action:nil];
    }
    
    vedatepiker=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width , 250)];
    [vedatepiker setBackgroundColor:[UIColor  colorWithRed:0.1804 green:0.6510 blue:0.50569 alpha:0.9f]];
    
    [self.view addSubview:vedatepiker];
    
    
    
    lbl_info=[[UILabel alloc]initWithFrame:CGRectMake(10, 10,self.view.frame.size.width-100, 20)];
    //[lbl_info setText:@"Select your Birthdate..."];
    [lbl_info setTextColor:[UIColor whiteColor]];
    [vedatepiker addSubview: lbl_info];
    
    
    
    UIButton *bttn_done=[UIButton buttonWithType:UIButtonTypeSystem];
    [bttn_done setFrame:CGRectMake(self.view.frame.size.width-80, 0, 70, 40)];
    [bttn_done setTitle:@"Done" forState:UIControlStateNormal];
    [bttn_done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bttn_done addTarget:self action:@selector(donedatePiker_action:) forControlEvents:UIControlEventTouchUpInside];
    [vedatepiker addSubview:bttn_done];
    
}




UIActionSheet *actionSheet;
NSString *pickerType;

- (IBAction)createActionSheet1:(id)sender {
    
    [self Viewpicker_bacvkground];
    
    [UIView animateWithDuration:0.5f animations:^{
        [ vedatepiker setFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width , 250)];
        
        [lbl_info setText:@"Select your Birthdate..."];
        
        
        
        
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
    [UIView animateWithDuration:0.5f animations:^{
        [ vedatepiker setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width , 250)];
    } completion:^(BOOL finished) {
        // onComplete
    }];
    
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

@end
