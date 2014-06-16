//
//  Sets.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/13/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface Sets : NSManagedObject

@property (nonatomic, retain) id repsAndWeightLifted;
@property (nonatomic, retain) Exercise *exercise;

@end
