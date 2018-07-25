//
//  FRPPhotoImporter.h
//  Playground
//
//  Created by HenryFan on 26/7/2018.
//  Copyright © 2018 HenryFanDi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FRPPhotoImporter : NSObject

// Sends the latest results from the API. This RACSignal will be a RACReplaySubject under the hood.

+ (RACSignal *)importPhotos;

@end

NS_ASSUME_NONNULL_END
