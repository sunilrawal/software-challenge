//
//  DBManager.m
//  VerveWhereWasI
//
//  Created by Sunil on 8/28/15.
//  Copyright (c) 2015 RawalVentures. All rights reserved.
//

#import "DBManager.h"
#import "AppDelegate.h"

@implementation DBManager {
    NSManagedObjectContext *context;
}

+(DBManager *)shared
{
    static dispatch_once_t onceToken;
    static DBManager* _shared;
    dispatch_once(&onceToken, ^{
        _shared = [DBManager new];
    });
    
    return _shared;
}

-(instancetype)init
{
    self = [super init];
    AppDelegate* appDelegate = [[UIApplication sharedApplication]delegate];
    context = appDelegate.managedObjectContext;
    return self;
}

-(NSManagedObject*)createNewEntity:(NSString*)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
}

-(NSArray*)fetchAll:(NSString*)entityName
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [request setEntity:entity];
    NSError *error = nil;
    id response = [context executeFetchRequest:request error:&error];
    return response;
}

-(NSManagedObject*)fetchEntity:(NSString*)entityName withColumn:(NSString*)columnName havingValue:(NSString*)value
{
    NSEntityDescription* entityDesc = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@=\"%@\"", columnName, value]];
    [request setPredicate:predicate];
    
    NSError* error;
    NSArray* matchingData = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject* obj in matchingData) {
        return obj;
    }
    return nil;
}

-(NSError*)saveContext
{
    NSError* error;
    [context save:&error];
    return error;
}

-(void)remove:(NSManagedObject*)obj
{
    [context deleteObject:obj];
    [self saveContext];
}




@end
