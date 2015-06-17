//
//  SearchVC.m
//  TestApp
//
//  Created by Karanbeer Singh on 11/26/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "SeachUserCollectionVC.h"
#import "SearchVC.h"
#import "DEMONavigationController.h"
#import "SearchUserVC.h"

#import "Singltonweblink.h"
#import "SCLAlertView.h"

#import "RangeSlider.h"

@interface SearchVC ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UIView *vedatepiker;
    UILabel *lbl_info;
    
    NSArray *city_arry;
    NSArray *languge_arry;
    NSArray *gender_arry;
    
    id response;
    
    NSString *string_category;
    NSArray *arry_tblmain;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tblmain;
@property (weak, nonatomic) IBOutlet UIButton *btn_tabl_end;
@property (weak, nonatomic) IBOutlet UISearchBar *serch_tblmain;
@property (weak, nonatomic) IBOutlet UIView *view_main;


@property (weak, nonatomic) IBOutlet UILabel *lbl_age;
@property (weak, nonatomic)  UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *btn_language;
@property (weak, nonatomic) IBOutlet UIButton *btn_country;
@property (weak, nonatomic) IBOutlet UIButton *btn_city;
@property (weak, nonatomic) IBOutlet NSString *str_gender;
@property (weak, nonatomic) IBOutlet UITextField *tf_agefrom;
@property (weak, nonatomic) IBOutlet UITextField *tf_ageto;

@property (weak, nonatomic) IBOutlet UIButton *btn_male;
@property (weak, nonatomic) IBOutlet UIButton *btn_female;
@property (weak, nonatomic) IBOutlet UIButton *btn_secret;


- (IBAction)ageslider_action:(id)sender;
- (IBAction)btnCountry_action:(id)sender;
- (IBAction)btnLanguge_action:(id)sender;
- (IBAction)btnCity_action:(id)sender;
- (IBAction)btnGender_action:(id)sender;
- (IBAction)btnSubmit_action:(id)sender;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _str_gender=@"Gender";
    city_arry=[[NSArray alloc]init];
    languge_arry=[[NSArray alloc]initWithArray:[Singltonweblink LanguageArraY]];
    
    self.title=@"Pally Search";
    
    languge_arry = [languge_arry sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    
    
    
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 21)];
    [button setImage:[UIImage imageNamed:@"menu@3x.png"] forState:UIControlStateNormal];
    [button addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    // Do any additional setup after loading the view from its nib.
    // [_ageSlider setHidden:TRUE];
    
    RangeSlider *slider = [[RangeSlider alloc] initWithFrame:CGRectMake(10, 120, self.view.frame.size.width-20, 20)]; // the slider enforces a height of 30, although I'm not sure that this is necessary
    
    //slider.minimumRangeLength = .03; // this property enforces a minimum range size. By default it is set to 0.0
    
    [slider setMinThumbImage:[UIImage imageNamed:@"rangethumb.png"]]; // the two thumb controls are given custom images
    [slider setMaxThumbImage:[UIImage imageNamed:@"rangethumb.png"]];
    [slider setMax:.70f];
    [slider setMin:.18f];
    
    UIImage *image; // there are two track images, one for the range "track", and one for the filled in region of the track between the slider thumbs
    
    [slider setTrackImage:[[UIImage imageNamed:@"fullrange.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(9.0, 9.0, 9.0, 9.0)]];
    
    image = [UIImage imageNamed:@"fillrange.png"];
    [slider setInRangeTrackImage:image];
    
    
    [slider addTarget:self action:@selector(updateRangeLabel:) forControlEvents:UIControlEventValueChanged];
    // [self.view addSubview:slider];
    
    
    
    
    // response=[[NSUserDefaults standardUserDefaults]objectForKey:@"cityarry"];
    response=[[Singltonweblink createInstance]cityname];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_tblmain .layer setCornerRadius:5.0f];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateRangeLabel:(RangeSlider *)slider{
    
    //  NSLog(@"Slider Range: %f - %f", _ageSlider.maximumValue, _ageSlider2.maximumValue);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



-(void)Viewpicker_bacvkground

{
    [_view_main setFrame: CGRectMake(0, 0, _view_main.frame.size.width, _view_main.frame.size.height)];
    if(vedatepiker)
    {
        
        [vedatepiker removeFromSuperview];
    }
    
    
    vedatepiker=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width , 250)];
    [vedatepiker setBackgroundColor:[UIColor  colorWithRed:0.1804 green:0.6510 blue:0.50569 alpha:0.9f]];
    
    [self.view addSubview:vedatepiker];
    
    
    
    lbl_info=[[UILabel alloc]initWithFrame:CGRectMake(10, 10,self.view.frame.size.width-100, 20)];
    
    [lbl_info setTextColor:[UIColor whiteColor]];
    [vedatepiker addSubview: lbl_info];
    
    
    
    UIButton *bttn_done=[UIButton buttonWithType:UIButtonTypeSystem];
    [bttn_done setFrame:CGRectMake(self.view.frame.size.width-80, 0, 70, 40)];
    [bttn_done setTitle:@"Done" forState:UIControlStateNormal];
    [bttn_done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bttn_done addTarget:self action:@selector(donedatePiker_action:) forControlEvents:UIControlEventTouchUpInside];
    [vedatepiker addSubview:bttn_done];
    
}

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
-(void) donedatePiker_action :(id)sender
{
    [UIView animateWithDuration:0.5f animations:^{
        [ vedatepiker setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width , 250)];
    } completion:^(BOOL finished) {
        
    }];
    
}


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
    else {
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
    else {
        return [languge_arry objectAtIndex:row];
    }
    
    
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag==1)
    {
        [self.btn_country setTitle:[self countryNames][row] forState:UIControlStateNormal];
        // city_arry= [response objectForKey:[self countryNames][row]];
        
        city_arry = [[NSSet setWithArray:[response objectForKey:[self countryNames][row]]] allObjects];
        city_arry = [city_arry sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        city_arry=[[NSSet setWithArray:city_arry] allObjects];
    }
    else  if(pickerView.tag==2){
        [self.btn_city setTitle:city_arry[row] forState:UIControlStateNormal];
    }
    
    else {
        [self.btn_language setTitle:languge_arry[row] forState:UIControlStateNormal];
        
    }
    
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if(textField.tag==9)
    {
        ary=[[self countryNames] mutableCopy];
        [ary removeAllObjects];
        
        // Filter the array using NSPredicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",textField.text];
        ary = [NSMutableArray arrayWithArray:[arry_tblmain filteredArrayUsingPredicate:predicate]];
        arry_tblmain=ary;
        
        [_tblmain reloadData];
    }
    else{
        if([textField.text intValue]<18 && [textField.text intValue]>70)
        {
            [self alertshow:1 :@"Age must be between 18 to 70 yeras " :@""];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (IBAction)ageslider_action:(id)sender {
    // NSLog(@"%f",self.ageSlider.value );
    //   [_lbl_age setText:[NSString stringWithFormat:@"%.0f",_ageSlider.value]];
    //NSLog(@"Slider Range: %f - %f", _ageSlider.maximumValue, _ageSlider2.maximumValue);
}



-(IBAction)btnViewTablehide:(id)sender
{
    // [_view_main setHidden:TRUE];
    [_view_main setFrame: CGRectMake(0, _view_main.frame.size.height, _view_main.frame.size.width, _view_main.frame.size.height)];
}

- (IBAction)btnCountry_action:(id)sender {
    
    [_view_main setFrame: CGRectMake(0, 0, _view_main.frame.size.width, _view_main.frame.size.height)];
    arry_tblmain=[self countryNames];
    string_category=@"Choose Country:";
    [_tblmain reloadData];
    
    
    
}

- (IBAction)btnLanguge_action:(id)sender {
    
    [_view_main setFrame: CGRectMake(0, 0, _view_main.frame.size.width, _view_main.frame.size.height)];
    arry_tblmain=languge_arry;
    string_category=@"Choose Languages:";
    [_tblmain reloadData];
    
    
}

- (IBAction)btnCity_action:(id)sender {
    
    [_view_main setFrame: CGRectMake(0, 0, _view_main.frame.size.width, _view_main.frame.size.height)];
    arry_tblmain=city_arry;
    string_category=@"Select City:";
    [_tblmain reloadData];
    //    [self Viewpicker_bacvkground];
    //    [lbl_info setText:@"Select your City..."];
    //    [UIView animateWithDuration:0.5f animations:^{
    //        [ vedatepiker setFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width , 250)];
    //
    //
    //        UIPickerView *picker_country =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, 325, 200)];
    //        [picker_country setDelegate:self];
    //        [picker_country setTag:2];
    //        [picker_country setDataSource:self];
    //        [vedatepiker addSubview:picker_country];
    //
    //
    //
    //
    //    } completion:^(BOOL finished) {
    //        // onComplete
    //    }];
    
}

- (IBAction)btnGender_action:(id)sender
{
    if([sender tag]==1)
    {
        [_btn_male setBackgroundImage:[UIImage imageNamed:@"male_mark_.png"] forState:UIControlStateNormal];
        [_btn_female setBackgroundImage:[UIImage imageNamed:@"female_without_mark_.png"] forState:UIControlStateNormal];
        [_btn_secret setBackgroundImage:[UIImage imageNamed:@"all_without_mark.png"] forState:UIControlStateNormal];
        _str_gender=@"Male";
        
    }
    else if ([sender tag]==2)
    {
        [_btn_male setBackgroundImage:[UIImage imageNamed:@"male_without_mark_.png"] forState:UIControlStateNormal];
        [_btn_female setBackgroundImage:[UIImage imageNamed:@"female_mark_.png"] forState:UIControlStateNormal];
        [_btn_secret setBackgroundImage:[UIImage imageNamed:@"all_without_mark.png"] forState:UIControlStateNormal];
        _str_gender=@"Female";
    }
    else{
        [_btn_male setBackgroundImage:[UIImage imageNamed:@"male_without_mark_.png"] forState:UIControlStateNormal];
        [_btn_female setBackgroundImage:[UIImage imageNamed:@"female_without_mark_.png"] forState:UIControlStateNormal];
        [_btn_secret setBackgroundImage:[UIImage imageNamed:@"all_mark.png"] forState:UIControlStateNormal];
        
        _str_gender=@"All";
    }
    
    
    
}

- (IBAction)btnSubmit_action:(id)sender {
    
    NSString *countyr;
    NSString *city;
    NSString *language;
    NSString *gender;
    
    if([_btn_country.titleLabel.text isEqual:@"Country"])
    {
        countyr=@"";
    }
    else{
        countyr=[_btn_country titleLabel].text;
    }
    
    if([_str_gender isEqualToString:@"Gender"])
    {
        gender=@"";
    }
    else{
        gender=_str_gender;
    }
    
    if([_btn_city.titleLabel.text isEqual:@"City"])
    {
        city=@"";
    }
    else{
        city=[_btn_city titleLabel].text;
    }
    if([_btn_language.titleLabel.text isEqual:@"Language"])
    {
        language=@"";
    }
    else{
        language=[_btn_language titleLabel].text;
    }
    
    if(language.length==0 && countyr.length==0 && city.length==0 && gender.length==0 && _tf_agefrom.text.length==0 && _tf_ageto.text.length==0)
    {
        [self alertshow:1 :@"" :@"Please select any field to search"];
    }
    else if([_tf_agefrom.text intValue]>[_tf_ageto.text intValue])
    {
        [self alertshow:1 :@"Age from must be less than age to" :@""];
    }
    else{
        
        
        
        NSDictionary *rspoDict=[ [Singltonweblink createInstance]SearchUser:_tf_agefrom.text :_tf_ageto.text  :language :countyr:city :gender];
        NSLog(@"%@",rspoDict);
        
        if([[[[[rspoDict objectForKey:@"response"]  objectForKey:@"res"] objectAtIndex:0]objectForKey:@"id"] isEqualToString:@"-1"])
        {
            [self alertshow:1 :@"No user found ! " :@""];
        }
        else{
            
            SeachUserCollectionVC *serchvcObj=[[SeachUserCollectionVC alloc]init]; //To add collection view in search screen
//            SearchUserVC *serchvcObj=[[SearchUserVC alloc]init];
            // NSLog(@"%@",[[rspoDict objectForKey:@"response"] objectForKey:@"res"]);
            serchvcObj.main_arry=[[rspoDict objectForKey:@"response"]  objectForKey:@"res"];
            [self.navigationController pushViewController:serchvcObj animated:YES];
        }
    }
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
-(void) firstButton
{
    
}


#pragma mark - SearchBAr methods
NSMutableArray *ary;
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    ary=[arry_tblmain mutableCopy];
    [ary removeAllObjects];
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
    ary = [NSMutableArray arrayWithArray:[arry_tblmain filteredArrayUsingPredicate:predicate]];
    arry_tblmain=ary;
    
    [_tblmain reloadData];
    //arry_tblmain=[self countryNames];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footer=[[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,36)];
    footer.backgroundColor=[UIColor whiteColor];
    
    UILabel *lbltit=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 120, 30)];
    [lbltit setText:string_category];
    [lbltit setFont: [UIFont systemFontOfSize:13.0f]];
    [lbltit setTextColor:[UIColor darkGrayColor]];
    [footer addSubview:lbltit];
    
    
    
    UITextField *tf=[[UITextField alloc]initWithFrame:CGRectMake(lbltit.frame.size.width+10,5, tableView.frame.size.width-lbltit.frame.size.width-15, 30)];
    [tf setDelegate:self];
    [tf setTag:9];
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    [footer addSubview:tf];
    
    UISearchBar *serchbartybl=[[UISearchBar alloc]init];
    [serchbartybl setFrame:CGRectMake(lbltit.frame.size.width+10, 0, tableView.frame.size.width-lbltit.frame.size.width+10, 40)];
    
    [serchbartybl setDelegate: self];
    
    //[serchbartybl.layer setBorderColor:(__bridge CGColorRef)([UIColor blackColor])];
    //[serchbartybl.layer setBorderWidth:1.0f];
    [serchbartybl setBarTintColor:[UIColor whiteColor]];
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([string_category isEqualToString:@"Choose Country:"])
    {
        return @"Country";
    }
    else if ([string_category isEqualToString:@"Choose Country:"])
    {
        return _btn_country.titleLabel.text;
    }
    else{
        return @"Language";
    }
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
    static NSString *CellIdentifier = @"Bubble Cell";
    
    
    
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = tableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [cell.textLabel setTextColor:[UIColor darkGrayColor]];
        
        
        
    }
    
    [cell.textLabel setText:[arry_tblmain objectAtIndex:indexPath.row]];
    
    
    
    
    
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([string_category isEqualToString:@"Country"])
    {
        if(![_btn_country.titleLabel.text isEqualToString:[arry_tblmain objectAtIndex:indexPath.row]])
        {
            [_btn_city setTitle:@"City" forState:UIControlStateNormal];
        }
        [_btn_country setTitle:[arry_tblmain objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        
        city_arry= [response objectForKey:[arry_tblmain objectAtIndex:indexPath.row]];
        
        city_arry=[[NSSet setWithArray:city_arry] allObjects];
        city_arry = [city_arry sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
    }
    else if ([string_category isEqualToString:@"City"])
    {
        [_btn_city setTitle:[arry_tblmain objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }
    else{
        [_btn_language setTitle:[arry_tblmain objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }
    [self btnViewTablehide:self.btn_tabl_end];
    
}


@end
