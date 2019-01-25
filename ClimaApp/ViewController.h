//
//  ViewController.h
//  ClimaApp
//
//  Created by user148651 on 1/24/19.
//  Copyright © 2019 user148651. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "WeatherData.h"
#import "ChangeCityViewController.h"

#define API_KEY @"f10b930f97547665ed5a9aa66c7b0625"
#define WEATHER_URL @"http://api.openweathermap.org/data/2.5/weather"


@interface ViewController : UIViewController<CLLocationManagerDelegate, ChangeCityDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) WeatherData *weatherData;

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UIButton *changeCityButton;

- (void)getWeatherData:(NSString*) url withParams:(NSDictionary*) params;
- (void)updateWeatherData:(id) responseObject;
- (void)updateUIWithWeatherData;

@end

