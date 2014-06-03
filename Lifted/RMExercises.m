//
//  RMExercises.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMExercises.h"

@implementation RMExercises

+ (NSMutableArray *)exerciseList

{
    NSMutableArray *exercises = [[NSMutableArray alloc] init];
    [exercises addObject:@"Barbell Bench Press"];
    [exercises addObject:@"Barbell Incline Press"];
    [exercises addObject:@"Barbell Decline Press"];
    [exercises addObject:@"Dumbbell Bench Press"];
    [exercises addObject:@"Dumbbell Incline Press"];
    [exercises addObject:@"Dumbbell Decline Press"];
    [exercises addObject:@"Dumbbell Flys"];
    
    return exercises;
}


@end
