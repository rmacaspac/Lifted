//
//  RMWorkoutObject.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/2/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMWorkoutObject : NSObject

@property (strong, nonatomic) NSMutableArray *workoutExercises;
@property (strong, nonatomic) NSString *workoutName;

- (id)initWithData:(NSDictionary *)workouts;

@end
