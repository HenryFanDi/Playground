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
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;

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
    
    // Deriving State
    // "Bind" our button’s enabled property to a signal that we’ll create.
//    RAC(self.createAccountButton, enabled) = [self.textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
//        return @([value rangeOfString:@"@"].location != NSNotFound);
//    }];
    
    RACSignal *validEmailSignal = [self.textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([value rangeOfString:@"@"].location != NSNotFound);
    }];
    
//    RAC(self.createAccountButton, enabled) = validEmailSignal;
//    RAC(self.textField, textColor) = [validEmailSignal map:^id _Nullable(id  _Nullable value) {
//        if ([value boolValue]) {
//            return [UIColor greenColor];
//        } else {
//            return [UIColor redColor];
//        }
//    }];
    
    // The signal block is executed whenever the button is pressed, and the "rac_command" property takes care of binding the enabled signal to the enabled state of the button.
    // We need to return a signal that will be sent down the executionSignals pipe belonging to the RACCommand
    // This lets you return a signal representing some work that will need to be done as the result of the button press.
    // The button will remain disabled until that signal returns its complete value (empty returns this value immediately).
    // Because we’re simply logging the result of the button press, we’re returning an empty signal in this case.
    self.createAccountButton.rac_command = [[RACCommand alloc] initWithEnabled:validEmailSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"Button was pressed");
        return [RACSignal empty];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
