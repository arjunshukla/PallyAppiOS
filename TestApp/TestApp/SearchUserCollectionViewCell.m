//
//  SearchUserCollectionViewCell.m
//  TestApp
//
//  Created by Swapnil Rane on 16/06/15.
//  Copyright (c) 2015 Karanbeer Singh. All rights reserved.
//

#import "SearchUserCollectionViewCell.h"

@implementation SearchUserCollectionViewCell

- (void)awakeFromNib {
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
    }
}

@end
