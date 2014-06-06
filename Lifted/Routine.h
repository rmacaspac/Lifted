//
//  Routine.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/6/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface Routine : NSManagedObject

@property (nonatomic, retain) NSString * routineName;
@property (nonatomic) NSTimeInterval routineDate;
@property (nonatomic, retain) NSMutableSet *routineExercises;
@end

@interface Routine (CoreDataGeneratedAccessors)

- (void)addRoutineExercisesObject:(Exercise *)value;
- (void)removeRoutineExercisesObject:(Exercise *)value;
- (void)addRoutineExercises:(NSMutableSet *)values;
- (void)removeRoutineExercises:(NSMutableSet *)values;

@end
