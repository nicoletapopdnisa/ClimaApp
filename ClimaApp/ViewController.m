//
//  ViewController.m
//  ClimaApp
//
//  Created by user148651 on 1/24/19.
//  Copyright © 2019 user148651. All rights reserved.
//

#import "ViewController.h"
#import "ChangeCityViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize locationManager;
@synthesize weatherData;

@synthesize cityNameLabel;
@synthesize temperatureLabel;
@synthesize weatherIcon;
@synthesize changeCityButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    weatherData = [[WeatherData alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

#pragma mark - Networking

- (void)getWeatherData:(NSString *)url withParams:(NSDictionary *)params {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:WEATHER_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Succes! Got weather data.");
        [self updateWeatherData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed retrieving data %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            self->cityNameLabel.text = @"Connection issues";
            self->weatherIcon.image = [UIImage imageNamed:@"dunno"];
            self->temperatureLabel.text = @"???";
        });
        
    }];
}

#pragma mark - JSON parsing

- (void)updateWeatherData:(id)responseObject {
    double result = [[[responseObject objectForKey:@"main"] objectForKey:@"temp"] doubleValue];
    
    weatherData.temperature = (int)(result - 273.15);
    weatherData.city = (NSString*)[responseObject objectForKey:@"name"];
    weatherData.condition = [[[responseObject objectForKey:@"weather"][0] objectForKey:@"id"] intValue];
    weatherData.weatherIconName = [weatherData updateWeatherIcon:weatherData.condition];
    
    [self updateUIWithWeatherData];
    
}

#pragma mark - UI updates

- (void)updateUIWithWeatherData {
    cityNameLabel.text = weatherData.city;
    temperatureLabel.text = [NSString stringWithFormat:@"%d °C", weatherData.temperature];
    weatherIcon.image = [UIImage imageNamed:weatherData.weatherIconName];
    
}

#pragma mark - location manager delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations objectAtIndex:locations.count - 1];
    
    if(location.horizontalAccuracy > 0) {
        [locationManager stopUpdatingLocation];
        
        NSString *latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        
        NSDictionary *params = @{@"lat": latitude, @"lon": longitude, @"appid": API_KEY};
        
        [self getWeatherData:WEATHER_URL withParams:params];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    cityNameLabel.text = @"Location unavailable.";
    weatherIcon.image = [UIImage imageNamed:@"dunno"];
    temperatureLabel.text = @"???";
}

#pragma mark - ChangeCityDelegate methods

- (void)enteredNewCityName:(NSString *)city {
    NSDictionary *params = @{@"q": city, @"appid": API_KEY};
    [self getWeatherData:WEATHER_URL withParams:params];
}

#pragma mark - IBActions

- (IBAction)changeCityNamePressed:(id)sender {
    [self performSegueWithIdentifier:@"changeCityName" sender:self];
}

#pragma mark - segue preparations

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"changeCityName"]) {
        ViewController *destinationViewController = segue.destinationViewController;
        ChangeCityViewController *destinationVC = (ChangeCityViewController*) destinationViewController;
        
        destinationVC.delegate = self;
        
    }
}


@end
