//
//  MasterViewController.m
//  sample
//
//  Created by Roopesh on 3/8/16.
//  Copyright © 2016 roopesh. All rights reserved.
//

#import "EpisodeListViewController.h"
#import "EpisodeDetailViewController.h"
#import "EpisodeDetails.h"


#define kEpisodeListBaseURLFormat @"http://www.omdbapi.com/?t=Game of Thrones&Season=%@"


@interface EpisodeListViewController ()

@end

@implementation EpisodeListViewController
@synthesize episodeList,alertView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedSeason = @"1";
    [self fetchEpisodeListForSeason:self.selectedSeason];
    

    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.detailViewController = (EpisodeDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
 
}
-(IBAction)showActionSheet:(id)sender{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Season 1"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  self.selectedSeason = @"1";
                                  [self fetchEpisodeListForSeason:self.selectedSeason];
                                  
                              }];
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Season 2"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  self.selectedSeason = @"2";
                                  [self fetchEpisodeListForSeason:self.selectedSeason];
                                  
                              }];
    UIAlertAction* button3 = [UIAlertAction
                              actionWithTitle:@"Season 3"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  self.selectedSeason = @"3";
                                  [self fetchEpisodeListForSeason:self.selectedSeason];
                                  
                              }];
    UIAlertAction* button4 = [UIAlertAction
                              actionWithTitle:@"Season 4"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  self.selectedSeason = @"4";
                                  [self fetchEpisodeListForSeason:self.selectedSeason];
                                  
                              }];
    UIAlertAction* button5 = [UIAlertAction
                              actionWithTitle:@"Season 5"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  self.selectedSeason = @"5";
                                  [self fetchEpisodeListForSeason:self.selectedSeason];
                                  
                              }];
    
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [alert addAction:button3];
    [alert addAction:button4];
    [alert addAction:button5];
    [self presentViewController:alert animated:YES completion:nil];
}

-(IBAction)refreshEpisodeList:(id)sender{

    [self fetchEpisodeListForSeason:self.selectedSeason];
}

- (void)getEpisodeListForSeason:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    self.episodeList = [NSMutableArray arrayWithArray:[json objectForKey:@"Episodes"]]; //2
    
    NSLog(@"episodes: %@", episodeList); //3
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //Your main thread code goes in here
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:YES];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)fetchEpisodeListForSeason:(NSString*)seasonNumber{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //Your main thread code goes in here
        alertView = [[UIAlertView alloc] initWithTitle:@"Loading data..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicator startAnimating];
        
        [alertView setValue:indicator forKey:@"accessoryView"];
        [alertView show];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        
        
        NSString *episdodeListURLString = [NSString stringWithFormat:kEpisodeListBaseURLFormat,seasonNumber];
        NSURL *episodeListURL = [NSURL URLWithString:[episdodeListURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSData* data = [NSData dataWithContentsOfURL:
                        episodeListURL];
        [self performSelectorOnMainThread:@selector(getEpisodeListForSeason:)
                               withObject:data waitUntilDone:YES];
        
    });
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *episodesummary = self.episodeList[indexPath.row];
        
        
        EpisodeDetailViewController *controller = (EpisodeDetailViewController *)[[segue destinationViewController] topViewController];
        EpisodeDetails *episodeData = [[EpisodeDetails alloc] init];
        episodeData.title = [episodesummary objectForKey:@"Title"];
        episodeData.imdbID = [episodesummary objectForKey:@"imdbID"];
        [controller setEpisodeData:episodeData];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        controller.navigationItem.title = episodeData.title;
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.episodeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *episodeSummary = self.episodeList[indexPath.row];
    cell.textLabel.text = [episodeSummary objectForKey:@"Title"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.episodeList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = [NSString stringWithFormat:@"Season %@",self.selectedSeason];
            break;

        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    //view.tintColor = [UIColor blackColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[self.view tintColor]];
    
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
}
@end
