//
//  homeTableViewCell.h
//  Beplused
//
//  Created by CS_Mac4 on 06/08/14.
//  Copyright (c) 2014 CS_Mac4. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PostCommentTableViewCell : UITableViewCell

@property (strong,nonatomic) UIImageView  *asyncPostImageView;
@property (strong,nonatomic) UIImageView  *asyncProfileImageView;

@property(strong ,nonatomic) UIActivityIndicatorView* mySpinner2 ;
@property(strong ,nonatomic) UIActivityIndicatorView* mySpinner ;

@property (strong,nonatomic) UILabel *lblPost;
@property (strong,nonatomic) UILabel *lbldate;




//@property (strong,nonatomic)UIImageView *baseImgView;

@property (strong,nonatomic)  UILabel  * nameLabel;



@property (strong,nonatomic) UIButton *commentButton;
@property (strong,nonatomic) UIButton *plusButton;

@property (strong,nonatomic) UIButton *EditButton;

@property (strong,nonatomic) UIView *vw;
@end
