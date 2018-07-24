//
//  ViewController.m
//  Playground
//
//  Created by henry.fan on 24/07/2018.
//  Copyright © 2018 HenryFanDi. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)dealloc {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *array = @[@(1), @(2), @(3)];

    RACSequence *stream = [array rac_sequence];

    // Map
    NSLog(@"%@", [stream map:^id _Nullable(id  _Nullable value) {
        return @(pow([value integerValue], 2));
    }]);

    NSLog(@"%@", [[[array rac_sequence] map:^id _Nullable(id  _Nullable value) {
        return @(pow([value integerValue], 2));
    }] array]);

    // Filter
    NSLog(@"%@", [[[array rac_sequence] filter:^BOOL(id  _Nullable value) {
        return [value integerValue] % 2 == 0;
    }] array]);

    // Fold
    NSLog(@"%@", [[[array rac_sequence] map:^id _Nullable(id  _Nullable value) {
        return [value stringValue];
    }] foldLeftWithStart:@"" reduce:^id _Nullable(id  _Nullable accumulator, id  _Nullable value) {
        return [accumulator stringByAppendingString:value];
    }]);
    
    // Signal
    // This particular signal doesn’t typically send error values and only sends a completion value when it’s deallocated
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"New value: %@", x);
    }];
    
//    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"New value: %@", x);
//    } error:^(NSError * _Nullable error) {
//        NSLog(@"Error: %@", error);
//    } completed:^{
//        NSLog(@"Completed.");
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
