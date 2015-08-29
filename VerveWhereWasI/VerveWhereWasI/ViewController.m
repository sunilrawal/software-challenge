//
//  ViewController.m
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import "ViewController.h"
#import "VerveLocationManager.h"
#import "UserLocation.h"
#import "DBManager.h"
#import <GoogleMaps/GoogleMaps.h>


@interface ViewController ()

@end

@implementation ViewController {
    NSArray* userLocations;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.permissionsView.handler = self;
    self.permissionsView.hidden = [VerveLocationManager shared].isAvailable;
    userLocations = [UserLocation allLocations];
    [self assignStatusText:UserLocationUpdating];
}

-(void)viewDidAppear:(BOOL)animated
{
    if ([VerveLocationManager shared].isAvailable)
    {
        [self permissionsViewClosed];
    }
}

-(void)permissionsViewClosed
{
    [self.permissionsView removeFromSuperview];
    // everything is taken care of -- location permissions are 'ok'.
    // can now start location tracking
    [[VerveLocationManager shared] startUpdating];
}

#pragma mark - top [status] area

-(void)assignStatusText:(UserLocationStatus)ulStatus
{
    NSString* txt = @"";
    switch (ulStatus)
    {
        case UserLocationUpdating:
            txt = @"Finding your location...";
            break;
        case UserLocationMultiple:
            txt = @"Found multiple possible locations!";
            break;
        case UserLocationFound:
            txt = @"Youve been found!";
            break;
    }
    
    self.statusLabel.text = txt;
}


#pragma mark - location table

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return userLocations.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
