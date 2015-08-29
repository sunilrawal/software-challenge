//
//  LocationManager.h
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define LOCATION_SELECTED_NOTIFICATION @"LocationSelected"

@interface VerveLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocation* lastRecordedLocation;

+(VerveLocationManager *)shared;
-(void)startUpdating;
-(void)stopUpdating;
-(void)findClosestPlacesWithCompletion:(void(^)(NSArray*))completion;
-(BOOL)isAvailable;

@end
