//
//  FriendTableViewCell.h
//  TestApp
//
//  Created by Karanbeer Singh on 3/30/15.
//  Copyright (c) 2015 Karanbeer Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView *imVW_friend;
@property(nonatomic,strong)IBOutlet UIImageView *imVW_country;
@property(nonatomic,strong)IBOutlet UIButton *btn_friend;
@property(nonatomic,strong)IBOutlet UILabel *lbl_name;
@property(nonatomic,strong)IBOutlet UILabel *lbl_detail;
@end
