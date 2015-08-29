//
//  UserLocationTexts.m
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UserLocation.h"

@interface UserLocationTests : XCTestCase

@end

@implementation UserLocationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUniqueKeyForGrouping {
    
    UserLocation* ul1 = [UserLocation create];
    UserLocation* ul2 = [UserLocation create];
    XCTAssertTrue([ul1.uniqueKeyForGrouping isEqualToString:ul2.uniqueKeyForGrouping]);
    
    ul1.address = @"ul1";
    ul2.address = @"ul2";
    
    XCTAssertFalse([ul1.uniqueKeyForGrouping isEqualToString:ul2.uniqueKeyForGrouping]);
}

-(void)testFormattedLocation {
    UserLocation* ul1 = [UserLocation create];
    double latitude = 123.456789;
    double longitude = 987.654321;
    ul1.latitude = @(latitude);
    ul1.longitude = @(longitude);
    NSString* expected = [NSString stringWithFormat:@"%0.6f, %0.6f", latitude, longitude];
    XCTAssertTrue([ul1.formattedLocation isEqualToString:expected]);
    
    ul1.address = @"ADDRESS";
    XCTAssertTrue([ul1.formattedLocation isEqualToString:ul1.address]);
    
    ul1.businessName = @"BUSINESS NAME";
    expected = [NSString stringWithFormat:@"%@\n%@", ul1.businessName, ul1.address];
    XCTAssertTrue([ul1.formattedLocation isEqualToString:expected]);
}

@end
