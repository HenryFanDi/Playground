//
//  ViewController.m
//  Playground
//
//  Created by henry.fan on 24/07/2018.
//  Copyright © 2018 HenryFanDi. All rights reserved.
//

#import "ViewController.h"
#import <RXCollections/RXCollection.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)dealloc {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *array = @[@(1), @(2), @(3)];

    // Map
    NSArray *mappedArray = [array rx_mapWithBlock:^id(id each) {
        return @(pow([each integerValue], 2));
    }];

    // Filter
    NSArray *filteredArray = [array rx_filterWithBlock:^BOOL(id each) {
        return ([each integerValue] % 2 == 0);
    }];

    // Fold
    NSNumber *sum = [array rx_foldWithBlock:^id(id memo, id each) {
        return @([memo integerValue] + [each integerValue]);
    }];

    [[array rx_mapWithBlock:^id(id each) {
        return [each stringValue];
    }] rx_foldInitialValue:@"" block:^id(id memo, id each) {
        return [memo stringByAppendingString:each];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
