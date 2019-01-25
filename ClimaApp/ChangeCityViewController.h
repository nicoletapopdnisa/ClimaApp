//
//  ChangeCityViewController.h
//  ClimaApp
//
//  Created by user148651 on 1/24/19.
//  Copyright © 2019 user148651. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ChangeCityDelegate

- (void)enteredNewCityName:(NSString*) city;

@end

@interface ChangeCityViewController : UIViewController

@property (nonatomic, retain) id delegate;
@property (weak, nonatomic) IBOutlet UITextField *changeCityTextField;

@end

NS_ASSUME_NONNULL_END
