//
//  RMSelectExercisesViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMSelectExercisesViewController.h"
#import "RMEditExerciseViewController.h"


@interface RMSelectExercisesViewController () <UITableViewDataSource, UITableViewDelegate, RMEditExerciseViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *exerciseObjects;
@property (strong, nonatomic) NSMutableArray *selectedExercise;
@property (strong, nonatomic) RMExerciseObject *exercises;

@property (strong, nonatomic) IBOutlet UITableView *exercisesTableView;

@end

@implementation RMSelectExercisesViewController

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
    
    self.exercisesTableView.delegate = self;
    self.exercisesTableView.dataSource = self;
    
    [self.exercisesTableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [RMExercisesData exerciseList][indexPath.row][WORKOUT_NAME];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[RMExercisesData exerciseList] count];
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *selectedExercise = [RMExercisesData exerciseList][indexPath.row];
    self.selectedExercise = selectedExercise;
    [self.delegate didSelectExercise:selectedExercise];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    NSLog(@"%@", selectedExercise);
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"exercisesToEditExercisesSegue" sender:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.identifier isEqualToString:@"exercisesToEditExercisesSegue"]) {
            if ([segue.destinationViewController isKindOfClass:[RMEditExerciseViewController class]]) {
                RMEditExerciseViewController *editExerciseVC = segue.destinationViewController;
                NSIndexPath *indexPath = sender;
                editExerciseVC.exerciseData = [RMExercisesData exerciseList][indexPath.row];
            }
        }
    }
    
    if ([segue.destinationViewController isKindOfClass:[RMEditExerciseViewController class]]) {
        RMEditExerciseViewController *editExerciseVC = segue.destinationViewController;
        editExerciseVC.delegate = self;
    }
}

#pragma mark - RMEditExerciseViewController Delegate

- (void)didChangeData:(RMExerciseObject *)editedExerciseObject
{
    self.exercises = editedExerciseObject;
    NSLog(@"new exercise object is %@", self.exercises);
}






@end
