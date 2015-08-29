//
//  UserLocation.m
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import "UserLocation.h"
#import "DBManager.h"

#define TABLE_NAME @"UserLocation"
#define GROUPING_KEY_COLUMN_NAME @"groupingKey"

@implementation UserLocation

@dynamic timeRecorded;
@dynamic longitude;
@dynamic latitude;
@dynamic address;
@dynamic businessName;
@dynamic count;
@dynamic groupingKey;
@dynamic placeTypes;

+(NSArray*)allLocations
{
    return [[DBManager shared] fetchAll:TABLE_NAME];
}

+(UserLocation*)create
{
    return (UserLocation*)[[DBManager shared] createNewEntity:TABLE_NAME];
}

-(void)save
{
    UserLocation* ul = (UserLocation*)[[DBManager shared] fetchEntity:TABLE_NAME withColumn:GROUPING_KEY_COLUMN_NAME havingValue:self.uniqueKeyForGrouping];
    int count = ul ? ul.count.intValue + 1 : 1;
    self.count = @(count);
    self.groupingKey = self.uniqueKeyForGrouping;
    self.timeRecorded = [NSDate date];
    if (ul) [[DBManager shared] remove:ul];
    [[DBManager shared] saveContext];
}

-(NSString*)uniqueKeyForGrouping
{
    return [NSString stringWithFormat:@"%@;%@", self.businessName, self.address];
}

-(NSString *)formattedLocation
{

    
    if (!self.businessName && !self.address)
        return [NSString stringWithFormat:@"Unknown place\n%0.6f, %0.6f", self.latitude.doubleValue, self.longitude.doubleValue];
 
    BOOL isSyntheticGeocode = self.businessName && self.businessName.length > 0 && [self.placeTypes containsString:@"synthetic_geocode"];
    if (isSyntheticGeocode) return [NSString stringWithFormat:@"Unknown place\n%@", self.businessName];
    
    if (!self.businessName)
        return self.address;
    
    return [NSString stringWithFormat:@"%@\n%@", self.businessName, self.address];
}

@end
