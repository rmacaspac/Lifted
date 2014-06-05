//
//  RMEditExerciseViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/4/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMEditExerciseViewController.h"
#import "RMExerciseObject.h"

@interface RMEditExerciseViewController ()

@property (strong, nonatomic) IBOutlet UITextField *workoutNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfSetsTextField;
@property (strong, nonatomic) IBOutlet UITextField *repMinTextField;
@property (strong, nonatomic) IBOutlet UITextField *repMaxTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;

@property (strong, nonatomic) RMExerciseObject *editedExerciseObject;

@end

@implementation RMEditExerciseViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.workoutNameTextField.text = [self.exerciseData valueForKey:WORKOUT_NAME];
    self.numberOfSetsTextField.text = [NSString stringWithFormat:@"%@", [self.exerciseData valueForKey:WORKOUT_SETS]];
    self.repMinTextField.text = [NSString stringWithFormat:@"%@", [self.exerciseData valueForKey:WORKOUT_REP_MIN]];
    self.repMaxTextField.text = [NSString stringWithFormat:@"%@", [self.exerciseData valueForKey:WORKOUT_REP_MAX]];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBActions

- (IBAction)doneBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.delegate didChangeData:[self editedExerciseObject]];
    NSLog(@"edited exercise object is %@", [self editedExerciseObject]);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helper Methods


- (NSDictionary *)newExerciseDataAsPropertyLists
{
    NSDictionary *exerciseData = @{WORKOUT_NAME : self.workoutNameTextField.text, WORKOUT_SETS : self.numberOfSetsTextField.text, WORKOUT_REP_MIN : self.repMinTextField.text, WORKOUT_REP_MAX : self.repMaxTextField.text};
    
    return exerciseData;
}


                                  
- (RMExerciseObject *)editedExerciseData
{
    RMExerciseObject *newExerciseData = [[RMExerciseObject alloc] init];
    
    newExerciseData.exerciseName = self.workoutNameTextField.text;
    newExerciseData.numberOfSets = [self.numberOfSetsTextField.text intValue];
    newExerciseData.repMinNumber = [self.repMinTextField.text intValue];
    newExerciseData.repMaxNumber = [self.repMaxTextField.text intValue];
     
    return newExerciseData;
}

@end
