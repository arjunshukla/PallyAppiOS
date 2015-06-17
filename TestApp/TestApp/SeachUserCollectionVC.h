//
//  SeachUserCollectionVC.h
//  TestApp
//
//  Created by Swapnil Rane on 16/06/15.
//  Copyright (c) 2015 Karanbeer Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeachUserCollectionVC : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *main_arry;
@end
