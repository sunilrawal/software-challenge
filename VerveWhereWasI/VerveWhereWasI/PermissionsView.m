//
//  PermissionsView.m
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import "PermissionsView.h"


@implementation PermissionsView {
    CLLocationManager* locationManager;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"PermissionsView" owner:self options:nil];
        UIView* v = [nibContents objectAtIndex:0];
        CGRect frame = v.frame;
        frame.size = [UIScreen mainScreen].bounds.size;
        v.frame = frame;
        [self addSubview:v];
    }
    return self;
}

- (IBAction)okButtonClicked:(id)sender
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        locationManager.delegate = nil;
        if (self.handler) [self.handler permissionsViewClosed];
    }
}
@end
