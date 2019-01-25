//
//  ChangeCityViewController.m
//  ClimaApp
//
//  Created by user148651 on 1/24/19.
//  Copyright © 2019 user148651. All rights reserved.
//

#import "ChangeCityViewController.h"

@interface ChangeCityViewController ()

@end

@implementation ChangeCityViewController

@synthesize delegate;
@synthesize changeCityTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - IBActions

- (IBAction)getWeatherPressed:(id)sender {
    NSString *cityName = changeCityTextField.text;
    if(cityName) {
        [delegate enteredNewCityName:cityName];
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
