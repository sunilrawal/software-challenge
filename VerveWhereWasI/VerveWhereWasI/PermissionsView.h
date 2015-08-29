//
//  PermissionsView.h
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PermissionsViewHandler.h"

@interface PermissionsView : UIView <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (strong, nonatomic) id<PermissionsViewHandler> handler;

@end
