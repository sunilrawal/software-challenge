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
    [self loadAllLocations];
    [self assignStatusText:UserLocationUpdating];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationSelected:) name:LOCATION_SELECTED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    if ([VerveLocationManager shared].isAvailable)
//    {
//        [self permissionsViewClosed];
//    }
//}

-(void)permissionsViewClosed
{
    [self.permissionsView removeFromSuperview];
    // everything is taken care of -- location permissions are 'ok'.
    // can now start location tracking
    [[VerveLocationManager shared] startUpdating];
}


-(void)appDidBecomeActive
{
    if ([VerveLocationManager shared].isAvailable)
    {
        [self permissionsViewClosed];
    }
}

-(void)loadAllLocations
{
    NSMutableArray* locs = [UserLocation allLocations].mutableCopy;
    [locs sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        UserLocation* ul1 = obj1;
        UserLocation* ul2 = obj2;
        return [ul2.count compare:ul1.count];
    }];
    
    userLocations = [NSArray arrayWithArray:locs];
}

#pragma mark - locations selected
-(void)locationSelected:(NSNotification*)note
{
    [self assignStatusText:UserLocationFound];
    GMSPlace* place = note.object;
    
    // whatever the place is, i'm going to make a new entry in the db
    UserLocation* userLocation = [UserLocation create];
    CLLocationCoordinate2D coordinate;
    
    if (place == nil)
    {
        CLLocation* loc = [[VerveLocationManager shared] lastRecordedLocation];
        coordinate = loc.coordinate;
    }
    else
    {
        userLocation.businessName = place.name;
        userLocation.address = place.formattedAddress;
    }
    
    userLocation.latitude = @(coordinate.latitude);
    userLocation.longitude = @(coordinate.longitude);
    [userLocation save];
    
    [self loadAllLocations];
    [self.locationsTable reloadData];
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
            txt = @"You've been found!";
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
    static NSString *cellName = @"locationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    
    UserLocation* ul = userLocations[indexPath.row];
    [self populateCell:cell withUserLocation:ul];
    return cell;
}

-(void)populateCell:(UITableViewCell*)cell withUserLocation:(UserLocation*)ul
{
    UILabel* nameAndAddress = (UILabel*)[cell viewWithTag:2];
    nameAndAddress.text = ul.formattedLocation;
    
    UILabel* countLabel = (UILabel*)[cell viewWithTag:3];
    countLabel.text = [NSString stringWithFormat:@"%@", ul.count];
}

@end
