//
//  RMExercises.h
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMExerciseObject : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *muscle;
@property (nonatomic) int repMax;
@property (nonatomic) int repMin;
@property (nonatomic) int numberOfSets;


- (id)initWithData:(NSDictionary *)exerciseInfo;

@end
