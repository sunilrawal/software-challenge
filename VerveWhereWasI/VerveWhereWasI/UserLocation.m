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

@implementation UserLocation

@dynamic timeRecorded;
@dynamic longitude;
@dynamic latitude;
@dynamic address;
@dynamic businessName;
@dynamic count;
@dynamic groupingKey;

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
    [[DBManager shared] saveContext];
}

-(NSString*)uniqueKeyForGrouping
{
    return [NSString stringWithFormat:@"%@;%@", self.businessName, self.address];
}

-(NSString *)formattedLocation
{
    if (!self.businessName && !self.address)
        return [NSString stringWithFormat:@"%0.6f, %0.6f", self.latitude.doubleValue, self.longitude.doubleValue];
 
    if (!self.businessName)
        return self.address;
    
    return [NSString stringWithFormat:@"%@\n%@", self.businessName, self.address];
}

@end
