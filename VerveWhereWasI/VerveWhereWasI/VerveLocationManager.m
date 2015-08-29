//
//  LocationManager.m
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import "VerveLocationManager.h"
#import <GoogleMaps/GoogleMaps.h>

// accuracy in meters
#define MIN_HORIZONTAL_ACCURACY 65

// max time in action [seconds]
#define MAX_UPDATE_TIME 15

@implementation VerveLocationManager {
    CLLocationManager* locationManager;
    NSDate* locationUpdateStarted;
    GMSPlacePicker* placePicker;
}

+(VerveLocationManager *)shared
{
    static dispatch_once_t onceToken;
    static VerveLocationManager* _shared;
    dispatch_once(&onceToken, ^{
        _shared = [VerveLocationManager new];
    });
    
    return _shared;
}

-(BOOL)isAvailable
{
    return [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse;
}

-(instancetype)init
{
    self = [super init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = MIN_HORIZONTAL_ACCURACY;
    return self;
}

-(void)startUpdating
{
    if (![self isAvailable])
    {
        [locationManager requestWhenInUseAuthorization];
        return;
    }
    
    locationUpdateStarted = [NSDate date];
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse) return;
    [self startUpdating];
}

-(void)stopUpdating
{
    [locationManager stopUpdatingLocation];
}

-(void)startMonitoringSignificantChanges
{
    [locationManager startMonitoringSignificantLocationChanges];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation* location = locations.lastObject;
//    if (location.horizontalAccuracy <= MIN_HORIZONTAL_ACCURACY || -[locationUpdateStarted timeIntervalSinceNow] > MAX_UPDATE_TIME)
//    {
//        NSLog(@"Location close enough");
//        [self stopUpdating];
//        [self showPlacePickerForLocation:location];
//    }
//    else
//    {
//        NSLog(@"Location recorded %0.4f %0.4f, accuracy %0.2f", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
//    }
}

#pragma mark - google places interface

-(void)showPlacePickerForLocation:(CLLocation*)location
{
    // taken from https://developers.google.com/places/ios/start
    CLLocationCoordinate2D center = location.coordinate;
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001);
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001);
    GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast coordinate:southWest];
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
    placePicker = [[GMSPlacePicker alloc] initWithConfig:config];

    [placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
        if (error != nil)
        {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        // do something with the place which was chosen [could be nil]
        
        
    }];
}

-(void)findClosestPlacesWithCompletion:(void(^)(NSArray*))completion
{
    // taken from https://developers.google.com/places/ios/start
    [[GMSPlacesClient sharedClient] currentPlaceWithCallback:^(GMSPlaceLikelihoodList *likelihoodList, NSError *error) {
        if (error != nil) {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            if (completion) completion(nil);
            return;
        }

//        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods) {
//            GMSPlace* place = likelihood.place;
//            NSLog(@"Current Place name %@ at likelihood %g", place.name, likelihood.likelihood);
//            NSLog(@"Current Place address %@", place.formattedAddress);
//            NSLog(@"Current Place attributions %@", place.attributions);
//            NSLog(@"Current PlaceID %@", place.placeID);
//        }
        if (completion) completion(likelihoodList.likelihoods);
    }];
}

@end
