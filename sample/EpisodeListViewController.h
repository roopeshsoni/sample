//
//  MasterViewController.h
//  sample
//
//  Created by Roopesh on 3/8/16.
//  Copyright © 2016 roopesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EpisodeDetailViewController;

@interface EpisodeListViewController : UITableViewController

@property (strong, nonatomic) EpisodeDetailViewController *detailViewController;
@property (strong, nonatomic) NSMutableArray *episodeList;
@property (strong, nonatomic) NSString *selectedSeason;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *actionButton;
@property (strong, nonatomic) UIAlertView *alertView;



@end

