//
//  UserLocation+Icons.m
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import "UserLocation+Icons.h"

@implementation UserLocation (Icons)

-(UIImage *)iconForType
{
    // place types are at https://developers.google.com/places/supported_types
    // [only doing a few for now]
    NSString* iconName = @"icon-pin.png";
    NSArray* types = self.placeTypes == nil || self.placeTypes.length == 0 ? @[] : [self.placeTypes componentsSeparatedByString:@","];
    for (NSString* placeType in types)
    {
        if ([placeType isEqualToString:@"store"]) iconName = @"icon-store.png";
        else if ([placeType isEqualToString:@"street_address"]) iconName = @"icon-house.png";
        else if ([placeType isEqualToString:@"restaurant"] || [placeType isEqualToString:@"cafe"]) iconName = @"icon-food.png";
    }
    return [UIImage imageNamed:iconName];
}
@end
