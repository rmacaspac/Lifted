//
//  Exercise.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/13/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Routine, Sets;

@interface Exercise : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * repMax;
@property (nonatomic, retain) NSString * repMin;
@property (nonatomic, retain) NSString * numberOfSets;
@property (nonatomic, retain) Routine *routine;
@property (nonatomic, retain) NSSet *sets;
@end

@interface Exercise (CoreDataGeneratedAccessors)

- (void)addSetsObject:(Sets *)value;
- (void)removeSetsObject:(Sets *)value;
- (void)addSets:(NSSet *)values;
- (void)removeSets:(NSSet *)values;

@end
