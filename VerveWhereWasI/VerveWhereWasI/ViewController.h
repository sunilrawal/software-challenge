//
//  ViewController.h
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PermissionsView.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *locationsTable;
@property (weak, nonatomic) IBOutlet PermissionsView *permissionsView;

@end

