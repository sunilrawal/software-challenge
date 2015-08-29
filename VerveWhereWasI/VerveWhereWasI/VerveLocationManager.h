//
//  LocationManager.h
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface VerveLocationManager : NSObject <CLLocationManagerDelegate>

+(VerveLocationManager *)shared;
-(void)startUpdating;
-(void)stopUpdating;
-(void)findClosestPlacesWithCompletion:(void(^)(NSArray*))completion;
-(BOOL)isAvailable;

@end
