//
//  RMExercisesData.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/4/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMExercisesData.h"
#import "Exercise.h"

@implementation RMExercisesData

- (id)init
{
    self = [self initWithData:nil];
    
    return self;
}

- (id)initWithData:(NSDictionary *)exerciseInfo
{
    self = [super init];
    
    self.exerciseName = exerciseInfo[EXERCISE_NAME];
    self.numberOfSets = [exerciseInfo[EXERCISE_SETS] intValue];
    self.repMin = [exerciseInfo[EXERCISE_REP_MIN] intValue];
    self.repMax = [exerciseInfo[EXERCISE_REP_MAX] intValue];
    
    return self;
}

+ (NSMutableArray *)exerciseList

{
    NSMutableArray *exercises = [[NSMutableArray alloc] init];
    
    NSDictionary *barbellBenchPress = @{EXERCISE_NAME : @"Barbell Bench Press", EXERCISE_SETS : @3, EXERCISE_REP_MIN : @1, EXERCISE_REP_MAX : @12};
    [exercises addObject:barbellBenchPress];
    
    NSDictionary *barbellInclinePress = @{EXERCISE_NAME : @"Barbell Incline Press", EXERCISE_SETS : @3, EXERCISE_REP_MIN : @1, EXERCISE_REP_MAX : @12};
    [exercises addObject:barbellInclinePress];
    
    NSDictionary *barbellDeclinePress = @{EXERCISE_NAME : @"Barbell Decline Press", EXERCISE_SETS : @3, EXERCISE_REP_MIN : @1, EXERCISE_REP_MAX : @12};
    [exercises addObject:barbellDeclinePress];
    
    NSDictionary *dumbbellBenchPress = @{EXERCISE_NAME : @"Dumbbell Bench Press", EXERCISE_SETS : @3, EXERCISE_REP_MIN : @1, EXERCISE_REP_MAX : @12};
    [exercises addObject:dumbbellBenchPress];
    
    NSDictionary *dumbbellInclinePress = @{EXERCISE_NAME : @"Dumbbell Incline Press", EXERCISE_SETS : @3, EXERCISE_REP_MIN : @1, EXERCISE_REP_MAX : @12};
    [exercises addObject:dumbbellInclinePress];
    
    NSDictionary *dumbbellDeclinePress = @{EXERCISE_NAME : @"Dumbbell Decline Press", EXERCISE_SETS : @3, EXERCISE_REP_MIN : @1, EXERCISE_REP_MAX : @12};
    [exercises addObject:dumbbellDeclinePress];
    
    NSDictionary *dumbbellFlys = @{EXERCISE_NAME : @"Dumbbell Flys", EXERCISE_SETS : @3, EXERCISE_REP_MAX : @1, EXERCISE_REP_MAX : @12};
    [exercises addObject:dumbbellFlys];
    
    return exercises;
}


    
@end
