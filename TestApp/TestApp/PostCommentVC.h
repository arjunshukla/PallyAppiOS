//
//  PostCommentVC.h
//  TestApp
//
//  Created by Karanbeer Singh on 12/16/14.
//  Copyright (c) 2014 Karanbeer Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCommentVC : UIViewController
@property(nonatomic,strong) UIImage *imgprofile;
@property(nonatomic,strong) UIImage *imgpost;
@property(strong,nonatomic)NSString *lbl_string;
@property(strong,nonatomic)NSString *lbl_post;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;
@property (strong, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UITextField *postTextField;
@property (weak, nonatomic) IBOutlet UIButton *postCommentBtn;

@end
