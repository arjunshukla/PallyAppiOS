//
//  SeachUserCollectionVC.m
//  TestApp
//
//  Created by Swapnil Rane on 16/06/15.
//  Copyright (c) 2015 Karanbeer Singh. All rights reserved.
//

#import "SeachUserCollectionVC.h"
#import "SearchUserCollectionViewCell.h"
#import "ProfileVCViewController.h"
#import "FriendProfileVC.h"
#import "Singltonweblink.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface SeachUserCollectionVC ()

@end

@implementation SeachUserCollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchUserCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_main_arry count];
}

- (SearchUserCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    [cell.userImage.layer setCornerRadius:40.0f];
    [cell.userImage setClipsToBounds:TRUE];
    [cell.userImage.layer setBorderWidth:3.0f];
    [cell.userImage.layer setBorderColor:[[UIColor colorWithRed:87.0f/255.0f green:187.0f/255.0f blue:157.0f/255.0f alpha:1.0f] CGColor]];
    UIActivityIndicatorView* mySpinner=mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    mySpinner.center = CGPointMake(cell.userImage.frame.size.width/2, cell.userImage.frame.size.height/2);
    
    [cell.userImage addSubview:mySpinner];
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:profimageURL,[[_main_arry objectAtIndex:indexPath.row ]objectForKey:@"userimage"]]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [mySpinner removeFromSuperview];
    }];
    [cell.userImage setTag:indexPath.row];
    [cell.userImage setUserInteractionEnabled:TRUE];
    
    [cell.userName setTextAlignment:NSTextAlignmentCenter];
    [cell.userName setFont:[UIFont boldSystemFontOfSize:14]];
    if(![[[_main_arry objectAtIndex:indexPath.row ]objectForKey:@"username"] isEqualToString: @""]) {
        [cell.userName setText:[[_main_arry objectAtIndex:indexPath.row ]objectForKey:@"username"]];
    }
    //To fix cell size allignment when username is not present
    else {
        [cell.userName setTextColor:[UIColor whiteColor]];
        [cell.userName setText:@"ABC"];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([[[_main_arry objectAtIndex:indexPath.row] objectForKey:@"id"] intValue]==[[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"] intValue])
    {
        ProfileVCViewController *profileobj=[[ProfileVCViewController alloc]init];
        [self .navigationController pushViewController:profileobj animated:YES];
    }
    else{
        
        FriendProfileVC *friendProfileVCOBJ;
        
        friendProfileVCOBJ =[[FriendProfileVC alloc]initWithNibName:@"FriendProfileVC" bundle:nil];
        
        friendProfileVCOBJ.useidfrnd=[[_main_arry objectAtIndex:indexPath.row] objectForKey:@"id"];
        [self.navigationController pushViewController:friendProfileVCOBJ animated:YES];
    }
}

@end
