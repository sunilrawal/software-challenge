//
//  DBManager.h
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DBManager : NSObject

+(DBManager *)shared;

-(NSArray*)fetchAll:(NSString*)entityName;
-(NSManagedObject*)createNewEntity:(NSString*)entityName;
-(NSError*)saveContext;
-(NSManagedObject*)fetchEntity:(NSString*)entityName withColumn:(NSString*)columnName havingValue:(NSString*)value;
-(void)remove:(NSManagedObject*)obj;

@end
