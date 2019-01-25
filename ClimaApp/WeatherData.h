//
//  WeatherData.h
//  ClimaApp
//
//  Created by user148651 on 1/24/19.
//  Copyright © 2019 user148651. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherData : NSObject

@property int temperature;
@property int condition;
@property NSString *city;
@property NSString *weatherIconName;

- (NSString*)updateWeatherIcon:(int) condition;

@end

NS_ASSUME_NONNULL_END
