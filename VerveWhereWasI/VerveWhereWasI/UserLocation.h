//
//  UserLocation.h
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    UserLocationUpdating,
    UserLocationMultiple,
    UserLocationFound
} UserLocationStatus;

@interface UserLocation : NSManagedObject

@property (nonatomic, retain) NSDate * timeRecorded;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * businessName;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSString * groupingKey;

-(void)save;
+(UserLocation*)create;
+(NSArray*)allLocations;

@end
