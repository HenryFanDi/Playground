//
//  FRPGalleryFlowLayout.m
//  Playground
//
//  Created by HenryFan on 26/7/2018.
//  Copyright © 2018 HenryFanDi. All rights reserved.
//

#import "FRPGalleryFlowLayout.h"

@implementation FRPGalleryFlowLayout

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.itemSize = CGSizeMake(145.0f, 145.0f);
        self.minimumInteritemSpacing = 10.0f;
        self.minimumLineSpacing = 10.0f;
        self.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    }
    return self;
}

@end
