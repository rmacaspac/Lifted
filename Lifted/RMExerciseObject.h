//
//  RMExercises.h
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMExerciseObject : NSObject

@property (strong, nonatomic) NSString *exerciseName;
@property (nonatomic) int numberOfSets;
@property (nonatomic) int repMinNumber;
@property (nonatomic) int repMaxNumber;
@property (nonatomic) float weightNumber;
@property (strong, nonatomic) NSMutableArray *exerciseData;

- (id)initWithData:(NSDictionary *)exerciseInfo;

@end
