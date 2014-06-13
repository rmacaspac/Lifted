//
//  RMSelectExercisesViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMSelectExercisesViewController.h"
#import "RMExercisesData.h"

@interface RMSelectExercisesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *exercisesTableView;

@property (strong, nonatomic) NSMutableArray *exerciseObject;

@end

@implementation RMSelectExercisesViewController

- (NSMutableArray *)exerciseObject
{
    if (!_exerciseObject) _exerciseObject = [[NSMutableArray alloc] init];
    return _exerciseObject;
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
    
    self.exercisesTableView.delegate = self;
    self.exercisesTableView.dataSource = self;
    
    // Enumerating through exerciseList in RMExercisesData for dictionary objects
    for (NSMutableDictionary *exercise in [RMExercisesData exerciseList]) {
        RMExerciseObject *exerciseObjects = [[RMExerciseObject alloc] initWithData:exercise];
        [self.exerciseObject addObject:exerciseObjects];
    }
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
    
    cell.textLabel.text = [self.exerciseObject valueForKey:EXERCISE_NAME][indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.exerciseObject count];
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMExerciseObject *exercise = self.exerciseObject[indexPath.row];
    [self.delegate didSelectExercise:exercise];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Exercise object selected is %@", exercise);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
