//
//  AppDelegate.h
//  Playground
//
//  Created by henry.fan on 24/07/2018.
//  Copyright © 2018 HenryFanDi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

