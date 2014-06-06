//
//  Exercise.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/6/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Routine, Sets;

@interface Exercise : NSManagedObject

@property (nonatomic, retain) NSString * exerciseName;
@property (nonatomic) int16_t repMax;
@property (nonatomic) int16_t repMin;
@property (nonatomic, retain) Routine *routine;
@property (nonatomic, retain) NSMutableSet *numberOfSets;
@end

@interface Exercise (CoreDataGeneratedAccessors)

- (void)addNumberOfSetsObject:(Sets *)value;
- (void)removeNumberOfSetsObject:(Sets *)value;
- (void)addNumberOfSets:(NSMutableSet *)values;
- (void)removeNumberOfSets:(NSMutableSet *)values;

@end
