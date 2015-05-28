//
//  Singltonweblink.m
//  TestApp
//
//  Created by Karanbeer Singh on 11/21/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import "Singltonweblink.h"
#import "Header.h"

static  Singltonweblink *createInstance;

@implementation Singltonweblink

+(id)createInstance
{
if(createInstance==nil)
{
    createInstance=[[Singltonweblink alloc]init];
}
    return createInstance;
}

+(NSArray *)LanguageArraY
{

NSArray *arry_language=[[NSArray alloc]initWithObjects:@"Persian",@"Albanian",@"Arabic",@"Catalan",
 @"Portuguese",@"English",@"Spanish",@"Armenian",
 @"German",@"Azerbaijani Turkic",@"Bangla",@"Belorussian",
 @"Dutch",@"French",@"Dzongkha",@"Bosnian",
 @"Aymara",@"Setswana",@"Malay",@"Bulgarian",
 @"Swahili",@"Kirundi",@"Khmer",@"Mandarin",
 @"Cantonese",@"Croatian",@"Greek",@"Czech",
 @"Danish",@"Tetum",@"Estonian",@"Somali",
 @"Amharic",@"Fijian",@"Finnish",@"Georgian",
 @"German",@"Creole",@"Hungarian",@"Icelandic",
 @"Hindi",@"Punjabi",@"Bengali",@"Bahasa",
 @"Kurdish",@"Hebrew",@"Italian",@"Japanese",
 @"Kazak",@"Korean",@"Kyrgyz",@"Lao",
 @"Latvian",@"Sesotho",@"Lithuanian",@"Luxermbourgish",
 @"Macedonian",@"Malagasy",@"Chichewa",@"Maldivian",
 @"Maltese",@"Marshallese",@"Moldovan",@"Mongolian",
 @"Serbian",@"Montenegrin",@"Burmese",@"Nauruan",
 @"Nepali",@"Norwegian",@"Tagalog",@"Polish",
 @"Romanian",@"Russian",@"Samoan",@"Serbian",
 @"Slovak",@"Slovenian",@"IsiZulu",@"Sinhala",
 @"Swedish",@"Thai",@"Tongan",@"Ukrainian",
 @"Uzbek",@"Bislama",@"Vietnamese",nil];

    
   arry_language= [arry_language sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    return arry_language;
}

-(CGSize )textsizer: (NSString *)text :(CGSize)cellsize
{
    CGSize textSize;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f]};
    
    CGRect rect = [text boundingRectWithSize:cellsize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];
    
    
    
    textSize = rect.size;
    
    return  textSize;
}

-(NSDictionary *)cityname{
    
    //    NSString *str=@"https://raw.githubusercontent.com/David-Haim/CountriesToCitiesJSON/master/countriesToCities.json";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    //NSLog(@"%@",filePath);

    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    NSError *error = nil;
  NSDictionary  *response = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    //NSLog(@"%@",response);
    return response;
    
   // [[NSUserDefaults standardUserDefaults] setObject:response forKey:@"cityarry"];
   // [[NSUserDefaults standardUserDefaults]synchronize];
    
}

-(NSDictionary *)Signup :(NSString *)enail :(NSString *)password

{
    NSURL * url=[NSURL URLWithString:SignupURL];
    NSMutableURLRequest *theLoginRequest = [NSMutableURLRequest requestWithURL:url];
    [theLoginRequest setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    
    
    /******** start main boundary ***********************/
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    /******** start main boundary ***********************/
    
    
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [theLoginRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    
    [body appendData:[self getbodyappend:@"email" :enail]];
    
    
    
    [body appendData:[self getbodyappend:@"password" :password]];
    
    
    
    
    
    /******** End main boundary ***********************/
    
    
    
    [theLoginRequest  setHTTPBody:body];
    
   // NSString *returnString2 = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",returnString2);
    
    
    NSError *error = nil;
    NSURLResponse *response= nil;
    
    NSData *data= [NSURLConnection sendSynchronousRequest:theLoginRequest returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (data)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        
         NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    
    return parsedData;
    

    
}



-(NSDictionary *)Signin :(NSString *)enail :(NSString *)password :(NSString *)tokenid

{
    NSURL * url=[NSURL URLWithString:SignIN];
    NSMutableURLRequest *theLoginRequest = [NSMutableURLRequest requestWithURL:url];
    [theLoginRequest setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    
    
    /******** start main boundary ***********************/
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    /******** start main boundary ***********************/
    
    
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [theLoginRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
  
    
    [body appendData:[self getbodyappend:@"email" :enail]];
         [body appendData:[self getbodyappend:@"password" :password]];
    
     [body appendData:[self getbodyappend:@"token_id" :tokenid]];
    
    
    
    
    
    /******** End main boundary ***********************/
    
    
    
    [theLoginRequest  setHTTPBody:body];
    
    //NSString *returnString2 = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
   // NSLog(@"%@",returnString2);
    
    
    NSError *error = nil;
    NSURLResponse *response= nil;
    
    NSData *data= [NSURLConnection sendSynchronousRequest:theLoginRequest returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (data)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        
         NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        [[NSUserDefaults standardUserDefaults]setObject:[[parsedData objectForKey:@"response"] objectForKey:@"username"] forKey:@"UserName"];
        [[NSUserDefaults standardUserDefaults]setObject:[[parsedData objectForKey:@"response"] objectForKey:@"userimage"] forKey:@"UserImage"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
    return parsedData;
    
    
    
}



-(NSDictionary *)ForegetPassword :(NSString *)enail :(NSString *)user_dob

{
    NSURL * url=[NSURL URLWithString:ForgetPassword];
    NSMutableURLRequest *theLoginRequest = [NSMutableURLRequest requestWithURL:url];
    [theLoginRequest setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    
    
    /******** start main boundary ***********************/
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    /******** start main boundary ***********************/
    
    
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [theLoginRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",enail ] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //param3
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"dob\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",user_dob ] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    /******** End main boundary ***********************/
    
    
    
    [theLoginRequest  setHTTPBody:body];
    
   // NSString *returnString2 = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",returnString2);
    
    
    NSError *error = nil;
    NSURLResponse *response= nil;
    
    NSData *data= [NSURLConnection sendSynchronousRequest:theLoginRequest returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (data)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        
        // NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    
    return parsedData;
    
    
    
}





-(NSMutableDictionary *)Updateprofile : (NSString *)userName  :(NSString *) dob :(NSString *) userGender : (NSData *)userImage :(NSString *) country : (NSString *)city :(NSString *) languag : (NSString *)desc :(NSString *) languag2 :(NSString *) languag3
{
    
    
    
    NSURL * url=[NSURL URLWithString:ProfileUpdate];
    NSMutableURLRequest *theLoginRequest = [NSMutableURLRequest requestWithURL:url];
    [theLoginRequest setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    
    
    /******** start main boundary ***********************/
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    /******** start main boundary ***********************/
    
    
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [theLoginRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
 
     [body appendData:[self getbodyappend:@"user_id" :[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"]]]];
    
    
    [body appendData:[self getbodyappend:@"username" :userName]];
    
    
    [body appendData:[self getbodyappend:@"language" :languag]];
    
    [body appendData:[self getbodyappend:@"language2" :languag2]];
    
    
    
    [body appendData:[self getbodyappend:@"language3" :languag3]];
    
    [body appendData:[self getbodyappend:@"city" :city]];
    
    [body appendData:[self getbodyappend:@"dob" :dob]];
    [body appendData:[self getbodyappend:@"country" :country]];
    [body appendData:[self getbodyappend:@"gender" :userGender]];
    
    [body appendData:[self getbodyappend:@"description" :desc]];
    
    
    
    
    if([userImage length]>0)
    {
        // NSLog(@"%@",uerImg);
        [body appendData:[self postImagetoserver:userImage :@"userimage"]];
        
        
        
    }
    
    
    
    
    
    /******** End main boundary ***********************/
    
    
    
    [theLoginRequest  setHTTPBody:body];
    
    NSError *error = nil;
    NSURLResponse *response= nil;
    
    NSData *data= [NSURLConnection sendSynchronousRequest:theLoginRequest returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (data)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
         NSLog(@"%@",[[parsedData objectForKey:@"response"] objectForKey:@"username"]);
        [[NSUserDefaults standardUserDefaults]setObject:[[parsedData objectForKey:@"response"] objectForKey:@"username"] forKey:@"UserName"];
        [[NSUserDefaults standardUserDefaults]setObject:[[parsedData objectForKey:@"response"] objectForKey:@"imageName"] forKey:@"UserImage"];
        [[NSUserDefaults standardUserDefaults ] setObject:[[parsedData objectForKey:@"response"] objectForKey:@"flag"] forKey:@"UserFlag"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    return parsedData;
    
    
    
}

-(NSData *)postImagetoserver :(NSData *)userimage :(NSString *)iamgeparam
{
    
        // NSLog(@"%@",uerImg);
        NSMutableData *body = [NSMutableData data];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[ NSString stringWithFormat:@"Content-Disposition: attachment; name=\"%@\"; filename=\%@\r\n",iamgeparam,@"myimage.jpg"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[NSData dataWithData:userimage]];
        
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    return body;
        
    

}
-(NSData *)getbodyappend :(NSString *)key :(NSString *)value
{
    
    
    
    
    /******** start main boundary ***********************/
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",value ] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return body;
}


-(NSMutableDictionary *)facebooklogin : (NSString *)userId : (NSString *)email : (NSString *)tokenid : (NSString *)username : (NSData *)userimage
{
    
    
    
    NSURL * url=[NSURL URLWithString:SignINFacebookURL];
    NSMutableURLRequest *theLoginRequest = [NSMutableURLRequest requestWithURL:url];
    [theLoginRequest setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    
    
    /******** start main boundary ***********************/
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    /******** start main boundary ***********************/
    
    
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [theLoginRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    [body appendData:[self getbodyappend:@"fid" :userId]];
    
     [body appendData:[self getbodyappend:@"email" :email]];
    
    
    
    [body appendData:[self getbodyappend:@"token_id" :tokenid]];
    
    [body appendData:[self getbodyappend:@"username" :username]];
    
    
    
   
    
    
    
    
    
    
    if([userimage length]>0)
    {
        // NSLog(@"%@",uerImg);
        
         [body appendData:[self postImagetoserver:userimage :@"userimage"]];

        
        
    }
    
    
    
    
    
    /******** End main boundary ***********************/
    
    
    
    [theLoginRequest  setHTTPBody:body];
    
    NSError *error = nil;
    NSURLResponse *response= nil;
    
    NSData *data= [NSURLConnection sendSynchronousRequest:theLoginRequest returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (data)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        [[NSUserDefaults standardUserDefaults]setObject:[[parsedData objectForKey:@"response"] objectForKey:@"username"] forKey:@"UserName"];
        [[NSUserDefaults standardUserDefaults]setObject:[[parsedData objectForKey:@"response"] objectForKey:@"userimage"] forKey:@"UserImage"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    return parsedData;
    
    
    
}








-(NSMutableDictionary *)signout : (NSString *)userId
{
    NSURL *url=[NSURL URLWithString:SignOutURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"id=%@",userId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
        
               
    }
    return parsedData;
    
}



-(NSMutableDictionary *)GetProfile : (NSString *)userId
{
    NSURL *url=[NSURL URLWithString:GetProfileInfo];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@",userId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
      //  NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        if(![[[[parsedData objectForKey:@"response"] objectForKey:@"res"]objectForKey:@"username"] isEqualToString:@"empty data"])
        {
        
        [[NSUserDefaults standardUserDefaults]setObject:[[[parsedData objectForKey:@"response"] objectForKey:@"res"]objectForKey:@"username"] forKey:@"UserName"];
        [[NSUserDefaults standardUserDefaults]setObject:[[[parsedData objectForKey:@"response"] objectForKey:@"res"]objectForKey:@"userimage"] forKey:@"UserImage"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
    }
    return parsedData;
    
}

-(NSMutableDictionary *)likePost : (NSString *)userId : (NSString *)PostID
{
    NSURL *url=[NSURL URLWithString:LikePost];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&post_id=%@",userId,PostID];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);

        

       
        
    }
    return parsedData;
    
}





-(NSMutableDictionary *)SearchUser : (NSString *)Sage : (NSString *)Eage : (NSString *)lang : (NSString *)country : (NSString *)city : (NSString *)gender
{
    NSURL *url=[NSURL URLWithString:SearchUserURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"start_age=%@&end_age=%@&language=%@&country=%@&city=%@&user_id=%@&gender=%@",Sage,Eage,lang,country,city,[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"],gender];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
        
        
        
    }
    return parsedData;
    
}




-(NSDictionary *)uplodpst :(NSString *)Userid :(NSString *)Staus :(NSData *)imagedata

{
    NSURL * url=[NSURL URLWithString:UploadPost];
    NSMutableURLRequest *theLoginRequest = [NSMutableURLRequest requestWithURL:url];
    [theLoginRequest setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    
    
    /******** start main boundary ***********************/
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    /******** start main boundary ***********************/
    
    
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [theLoginRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    //param2
     [body appendData:[self getbodyappend:@"post_by_id" :Userid]];
    
    
    [body appendData:[self getbodyappend:@"status_text" :Staus]];
    
    
    
    
    
    
    
    
    
    if([imagedata length]>0)
    {
        // NSLog(@"%@",uerImg);
         [body appendData:[self postImagetoserver:imagedata :@"post_image"]];

        
        
    }
    
    /******** End main boundary ***********************/
    
    
    
    [theLoginRequest  setHTTPBody:body];
    
    // NSString *returnString2 = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",returnString2);
    
    
    NSError *error = nil;
    NSURLResponse *response= nil;
    
    NSData *data= [NSURLConnection sendSynchronousRequest:theLoginRequest returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (data)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        
         NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
      
    }
    
    return parsedData;
    
    
    
}
-(NSMutableDictionary *)GetPost : (NSString *)userId :(NSString *)page_no
{
    NSURL *url=[NSURL URLWithString:FetchPost];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&page_no=%@",userId,page_no];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",returnString);
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
       
    }
    return parsedData;
    
}

-(NSMutableDictionary *)getallcomment : (NSString *)postId
{
    NSURL *url=[NSURL URLWithString:getallcommentsURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"post_id=%@",postId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  //  NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        // NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}

-(NSMutableDictionary *)getonlinefriend : (NSString *)userId
{
    NSURL *url=[NSURL URLWithString:onlineUserFriendListURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"uid=%@",userId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
      //  NSLog(@"Returning Result = %@",parsedData);
        // NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}




-(NSMutableDictionary *)commntonPost : (NSString *)userId : (NSString *)Postid : (NSString *)commentText
{
    NSURL *url=[NSURL URLWithString:addcomentonPstURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"comment_by_id=%@&comment_post_id=%@&comment_text=%@",userId,Postid,commentText];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}






-(NSMutableDictionary *)GetFriendProfile : (NSString *)userId : (NSString *)frindID
{
    NSURL *url=[NSURL URLWithString:FriendProfileURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&friend_id=%@",userId,frindID];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
         NSLog(@"Returning Result = %@",parsedData);
         NSLog(@"%@",returnString);
        
    }
    return [parsedData objectForKey:@"response"];
    
}


-(NSMutableDictionary *)unfrienduser : (NSString *)userId : (NSString *)frindID
{
    NSURL *url=[NSURL URLWithString:unfriendURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&friend_id=%@",userId,frindID];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    return [parsedData objectForKey:@"response"];
    
}




-(NSMutableDictionary *)blockuser : (NSString *)userId : (NSString *)frindID
{
    NSURL *url=[NSURL URLWithString:BlockedUserURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&friend_id=%@",userId,frindID];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    return [parsedData objectForKey:@"response"];
    
}



-(NSMutableDictionary *)SendFrendRequst : (NSString *)userId : (NSString *)frindID
{
    NSURL *url=[NSURL URLWithString:SendFrndRequestURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&friend_id=%@",userId,frindID];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}

-(NSMutableDictionary *)CheckFrendRequst : (NSString *)userId
{
    NSURL *url=[NSURL URLWithString:CheckFrndRequestURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@",userId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
   // NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
       // NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}

-(NSMutableDictionary *)AcceptFrendRequst : (NSString *)reqId : (NSString *)ststus
{
    NSURL *url=[NSURL URLWithString:AcceptFriendReqURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"request_id=%@&aprove_status=%@",reqId,ststus];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}


-(NSMutableDictionary *)MyFriendList : (NSString *)userId
{
    NSURL *url=[NSURL URLWithString:FrndListRequestURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"uid=%@",userId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  //  NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
       // NSLog(@"Returning Result = %@",parsedData);
       // NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}


-(NSMutableDictionary *)BlockedFriendList : (NSString *)userId
{
    NSURL *url=[NSURL URLWithString:blockeduserListURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"uid=%@",userId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}





-(NSMutableDictionary *)resetPassword : (NSString *)userId : (NSString *)oldpassword : (NSString *)newpassword
{
    NSURL *url=[NSURL URLWithString:resepasswrdURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"id=%@&old_password=%@&new_password=%@",userId,oldpassword,newpassword];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}






-(NSMutableDictionary *)sendMessage : (NSString *)userId : (NSString *)sendtoId : (NSString *)message :(NSData *)sounddata
{
   
    
  
    
    NSURL *url=[NSURL URLWithString:messageURL];
    
    NSMutableURLRequest *theLoginRequest = [NSMutableURLRequest requestWithURL:url];
    [theLoginRequest setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    
    
    /******** start main boundary ***********************/
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    /******** start main boundary ***********************/
    
    
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [theLoginRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    
    
     [body appendData:[self getbodyappend:@"send_by" :userId]];
    
    

    [body appendData:[self getbodyappend:@"send_to" :sendtoId]];
    
     [body appendData:[self getbodyappend:@"text" :message]];
    

    

    
    
    
    
    
    if([sounddata length]>0)
    {
        // NSLog(@"%@",uerImg);
        
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[ NSString stringWithFormat:@"Content-Disposition: attachment; name=\"voice_document\"; filename=\%@\r\n",@"mysound.m4p"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[NSData dataWithData:sounddata]];
        
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
    }
    
    /******** End main boundary ***********************/
    
    
    
    [theLoginRequest  setHTTPBody:body];
    
    // NSString *returnString2 = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",returnString2);
    
    
    NSError *error = nil;
    NSURLResponse *response= nil;
    
    NSData *data= [NSURLConnection sendSynchronousRequest:theLoginRequest returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (data)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        
        // NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    
    return parsedData;

    
}
-(NSMutableDictionary *)FetchMessage : (NSString *)userId : (NSString *)sendtoId
{
    NSURL *url=[NSURL URLWithString:FetchmessageURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&friend_id=%@",userId,sendtoId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}


-(NSMutableDictionary *)settingstatus : (NSString *)userId : (NSString *)FrndReqSts : (NSString *)NotificReqSts
{
    NSURL *url=[NSURL URLWithString:settingStausURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&friend_request_status=%@&notification_status=%@",userId,FrndReqSts,NotificReqSts];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
        NSLog(@"%@",returnString);
        
    }
    return parsedData;
    
}



-(NSMutableDictionary *)GetNotificationList : (NSString *)userId
{
    NSURL *url=[NSURL URLWithString:notificationListURL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@",userId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // now lets make the connection to the web
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
   // NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
      // NSLog(@"ff  %@",returnString);
    
    NSMutableDictionary *parsedData;
    if (returnData)
    {
        NSError *localError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&localError];
        
        NSLog(@"Returning Result = %@",parsedData);
     
        
    }
    return parsedData;
    
}



@end
