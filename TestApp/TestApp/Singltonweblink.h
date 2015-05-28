//
//  Singltonweblink.h
//  TestApp
//
//  Created by Karanbeer Singh on 11/21/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define profimageURL @"http://108.179.196.157/~pallyapp/dev/ws/user_image/%@"

@interface Singltonweblink : NSObject
{
    Singltonweblink *createInstance;
}



+(id)createInstance;

+(NSArray *)LanguageArraY;

-(NSDictionary *)cityname;
-(CGSize )textsizer: (NSString *)text :(CGSize)cellsize;


-(NSDictionary *)Signup :(NSString *)enail :(NSString *)password;
-(NSDictionary *)Signin :(NSString *)enail :(NSString *)password :(NSString *)tokenid;
-(NSMutableDictionary *)facebooklogin : (NSString *)userId : (NSString *)email : (NSString *)tokenid : (NSString *)username : (NSData *)userimage;
-(NSMutableDictionary *)signout : (NSString *)userId;
-(NSDictionary *)ForegetPassword :(NSString *)enail :(NSString *)user_id;

-(NSMutableDictionary *)Updateprofile : (NSString *)userName  :(NSString *) dob :(NSString *) userGender : (NSData *)userImage :(NSString *) country : (NSString *)city :(NSString *) languag : (NSString *)desc :(NSString *) languag2 :(NSString *) languag3;
-(NSMutableDictionary *)GetProfile : (NSString *)userId;




-(NSDictionary *)uplodpst :(NSString *)Userid :(NSString *)Staus :(NSData *)imagedata;
-(NSMutableDictionary *)GetPost : (NSString *)userId :(NSString *)page_no;
-(NSMutableDictionary *)likePost : (NSString *)userId : (NSString *)PostID;

-(NSMutableDictionary *)commntonPost : (NSString *)userId : (NSString *)Postid : (NSString *)commentText;
-(NSMutableDictionary *)getallcomment : (NSString *)postId;


-(NSMutableDictionary *)SearchUser : (NSString *)Sage : (NSString *)Eage : (NSString *)lang : (NSString *)country : (NSString *)city : (NSString *)gender;





-(NSMutableDictionary *)GetFriendProfile : (NSString *)userId : (NSString *)frindID;

-(NSMutableDictionary *)SendFrendRequst : (NSString *)userId : (NSString *)frindID;
-(NSMutableDictionary *)CheckFrendRequst : (NSString *)userId;
-(NSMutableDictionary *)AcceptFrendRequst : (NSString *)reqId : (NSString *)ststus;
-(NSMutableDictionary *)MyFriendList : (NSString *)userId;
-(NSMutableDictionary *)BlockedFriendList : (NSString *)userId;

-(NSMutableDictionary *)getonlinefriend : (NSString *)userId;
-(NSMutableDictionary *)blockuser : (NSString *)userId : (NSString *)frindID;
-(NSMutableDictionary *)unfrienduser : (NSString *)userId : (NSString *)frindID;


-(NSMutableDictionary *)FetchMessage : (NSString *)userId : (NSString *)sendtoId;


-(NSMutableDictionary *)resetPassword : (NSString *)userId : (NSString *)oldpassword : (NSString *)newpassword;
//-(NSMutableDictionary *)sendMessage : (NSString *)userId : (NSString *)sendtoId : (NSString *)message;


-(NSMutableDictionary *)sendMessage : (NSString *)userId : (NSString *)sendtoId : (NSString *)message :(NSData *)sounddata;

-(NSMutableDictionary *)GetNotificationList : (NSString *)userId;

-(NSMutableDictionary *)settingstatus : (NSString *)userId : (NSString *)FrndReqSts : (NSString *)NotificReqSts;
@end
