//
//  DEMOMenuViewController.h
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"



@interface DEMOMenuViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    
}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)  UILabel *label;
@property(nonatomic,strong)  UIImageView *flag_imgvw;;
@end
