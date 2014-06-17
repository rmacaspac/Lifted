//
//  RMEditExerciseViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/4/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMEditExerciseViewController.h"

@interface RMEditExerciseViewController ()

@property (strong, nonatomic) IBOutlet UITextField *workoutNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfSetsTextField;
@property (strong, nonatomic) IBOutlet UITextField *repMinTextField;
@property (strong, nonatomic) IBOutlet UITextField *repMaxTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;

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
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.workoutNameTextField.text = [self.selectedExercise valueForKey:EXERCISE_NAME];
    self.numberOfSetsTextField.text = [NSString stringWithFormat:@"%@", [self.selectedExercise valueForKey:EXERCISE_SETS]];
    self.repMinTextField.text = [NSString stringWithFormat:@"%@", [self.selectedExercise valueForKey:EXERCISE_REP_MIN]];
    self.repMaxTextField.text = [NSString stringWithFormat:@"%@", [self.selectedExercise valueForKey:EXERCISE_REP_MAX]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)doneBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.delegate didChangeData:[self newExerciseObject] underIndexPath:self.selectedIndexPath];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helper Methods

- (RMExerciseObject *)newExerciseObject
{
    NSDictionary *exerciseDataAsPropertyLists = @{EXERCISE_NAME : self.workoutNameTextField.text, EXERCISE_SETS : self.numberOfSetsTextField.text, EXERCISE_REP_MIN : self.repMinTextField.text, EXERCISE_REP_MAX : self.repMaxTextField.text};
    
    RMExerciseObject *newExerciseObject = [[RMExerciseObject alloc] initWithData:exerciseDataAsPropertyLists];
    
    return newExerciseObject;
}

@end
