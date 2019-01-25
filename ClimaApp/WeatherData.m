//
//  WeatherData.m
//  ClimaApp
//
//  Created by user148651 on 1/24/19.
//  Copyright © 2019 user148651. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData

@synthesize temperature = _temperature;
@synthesize condition = _condition;
@synthesize city = _city;
@synthesize weatherIconName = _weatherIconName;

- (NSString *)updateWeatherIcon:(int)condition {
    switch (condition) {
        case 0 ... 300:
            return @"tstorm1";
            break;
            
        case 301 ... 500:
            return @"light_rain";
            break;
            
        case 501 ... 600:
            return @"shower3";
            break;
            
        case 601 ... 700:
            return @"snow4";
            break;
            
        case 701 ... 771:
            return @"fog";
            break;
            
        case 772 ... 799:
            return @"tstorm3";
            break;
            
        case 800:
            return @"sunny";
            break;
            
        case 801 ... 804:
            return @"cloudy2";
            
        case 900 ... 902:
            return @"tstorm3";
            break;
            
        case 905 ... 1000:
            return @"tstorm3";
            break;
            
        case 903:
            return @"snow5";
            break;
            
        case 904:
            return @"sunny";
            break;
            
        default:
            return @"dunno";
            break;
    }
}

@end
