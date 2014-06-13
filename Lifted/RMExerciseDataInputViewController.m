//
//  RMIndividualWorkoutViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/3/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMExerciseDataInputViewController.h"

@interface RMExerciseDataInputViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (strong, nonatomic) IBOutlet UITableView *workoutTableView;
@property (strong, nonatomic) IBOutlet UILabel *repMinLabel;
@property (strong, nonatomic) IBOutlet UILabel *repMaxLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) NSArray *workoutDataOnRow;
@property (strong, nonatomic) NSMutableArray *workoutData;

@end

@implementation RMExerciseDataInputViewController

- (NSMutableArray *)workoutData
{
    if (!_workoutData) {
        _workoutData = [[NSMutableArray alloc] init];
    }
    return _workoutData;
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
    
    self.workoutTableView.dataSource = self;
    self.workoutTableView.delegate = self;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    
    self.exerciseNameLabel.text = [self.exerciseData valueForKey:@"name"];
    self.repMinLabel.text = [NSString stringWithFormat:@"%@",[self.exerciseData valueForKey:EXERCISE_REP_MIN]];
    self.repMaxLabel.text = [NSString stringWithFormat:@"%@",[self.exerciseData valueForKey:EXERCISE_REP_MAX]];
    
    NSLog(@"the exercises data for routine is %@", self.workoutData);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)finishBarButtonItemPressed:(UIBarButtonItem *)sender
{
    
}

#pragma mark - UITableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    RMExerciseDataInputTableViewCell *cell = [self.workoutTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    if (indexPath.section == 0) {
        cell.numberOfRepsTextField.text = nil;
        cell.weightTextField.text = nil;
    } else {
        cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        cell.textLabel.text = @"Add Set";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - RMExerciseDataInputTableViewCell Delegate

-(void)didEnterData:(NSArray *)dataEntered
{
    self.workoutDataOnRow = dataEntered;
    NSLog(@"the row data for routine is %@", self.workoutDataOnRow);
}

@end
