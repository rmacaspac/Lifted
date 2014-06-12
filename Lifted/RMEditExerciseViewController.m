//
//  RMEditExerciseViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/4/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMEditExerciseViewController.h"
#import "Routine.h"
#import "RMCoreDataHelper.h"

@interface RMEditExerciseViewController ()

@property (strong, nonatomic) IBOutlet UITextField *workoutNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfSetsTextField;
@property (strong, nonatomic) IBOutlet UITextField *repMinTextField;
@property (strong, nonatomic) IBOutlet UITextField *repMaxTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;

@end

@implementation RMEditExerciseViewController

- (NSMutableArray *)exerciseData
{
    if (!_exerciseData) {
        _exerciseData = [[NSMutableArray alloc] init];
    }
    return _exerciseData;
}


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
    
//    [self.exerciseData addObject:self.selectedExercise];
//    NSLog(@"Exercise data is %@", self.exerciseData);
    
//    NSIndexPath *path;
    self.workoutNameTextField.text = [self.selectedExercise valueForKey:@"exerciseName"];
    self.repMinTextField.text = [NSString stringWithFormat:@"%@", [self.selectedExercise valueForKey:@"repMin"]];
    self.repMaxTextField.text = [NSString stringWithFormat:@"%@", [self.selectedExercise valueForKey:@"repMax"]];
    
    NSLog(@"Index path is %i", self.selectedIndexPath);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 

#pragma mark - IBActions

- (IBAction)doneBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.delegate didChangeData:[self newExerciseObject] underIndexPath:self.selectedIndexPath];
    NSLog(@"Edited exercise data is %@", [self newExerciseObject]);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helper Methods


- (RMExerciseObject *)newExerciseObject
{
    NSDictionary *exerciseDataAsPropertyLists = @{EXERCISE_NAME : self.workoutNameTextField.text, EXERCISE_SETS : [self.selectedExercise valueForKey:@"sets"], EXERCISE_REP_MIN : self.repMinTextField.text, EXERCISE_REP_MAX : self.repMaxTextField.text};
    
    RMExerciseObject *newExerciseObject = [[RMExerciseObject alloc] initWithData:exerciseDataAsPropertyLists];
    
    return newExerciseObject;
    
}

@end
