//
//  RMExercisesData.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/4/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMExercisesData.h"

@implementation RMExercisesData

+ (NSMutableArray *)exerciseList

{
    NSMutableArray *exercises = [[NSMutableArray alloc] init];
    
    NSDictionary *barbellBenchPress = @{WORKOUT_NAME : @"Barbell Bench Press", WORKOUT_SETS : @3, WORKOUT_REP_MIN : @0, WORKOUT_REP_MAX : @12, WORKOUT_WEIGHT : @0};
    [exercises addObject:barbellBenchPress];
    
    NSDictionary *barbellInclinePress = @{WORKOUT_NAME : @"Barbell Incline Press", WORKOUT_SETS : @3, WORKOUT_REP_MIN : @0, WORKOUT_REP_MAX : @12, WORKOUT_WEIGHT : @0};
    [exercises addObject:barbellInclinePress];
    
    NSDictionary *barbellDeclinePress = @{WORKOUT_NAME : @"Barbell Decline Press", WORKOUT_SETS : @3, WORKOUT_REP_MIN : @0, WORKOUT_REP_MAX : @12, WORKOUT_WEIGHT : @0};
    [exercises addObject:barbellDeclinePress];
    
    NSDictionary *dumbbellBenchPress = @{WORKOUT_NAME : @"Dumbbell Bench Press", WORKOUT_SETS : @3, WORKOUT_REP_MIN : @0, WORKOUT_REP_MAX : @12, WORKOUT_WEIGHT : @0};
    [exercises addObject:dumbbellBenchPress];
    
    NSDictionary *dumbbellInclinePress = @{WORKOUT_NAME : @"Dumbbell Incline Press", WORKOUT_SETS : @3, WORKOUT_REP_MIN : @0, WORKOUT_REP_MAX : @12, WORKOUT_WEIGHT : @0};
    [exercises addObject:dumbbellInclinePress];
    
    NSDictionary *dumbbellDeclinePress = @{WORKOUT_NAME : @"Dumbbell Decline Press", WORKOUT_SETS : @3, WORKOUT_REP_MIN : @0, WORKOUT_REP_MAX : @12, WORKOUT_WEIGHT : @0};
    [exercises addObject:dumbbellDeclinePress];
    
    NSDictionary *dumbbellFlys = @{WORKOUT_NAME : @"Dumbbell Flys", WORKOUT_SETS : @3, WORKOUT_REP_MIN : @0, WORKOUT_REP_MAX : @12, WORKOUT_WEIGHT : @0};
    [exercises addObject:dumbbellFlys];
    
    return exercises;
}

    
@end
