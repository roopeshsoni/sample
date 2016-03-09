//
//  DetailViewController.h
//  sample
//
//  Created by Roopesh on 3/8/16.
//  Copyright © 2016 roopesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EpisodeDetails.h"

@interface EpisodeDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong,nonatomic) NSDictionary* episodeDetails;
@property (strong, nonatomic) EpisodeDetails *episodeData;
@property (strong, nonatomic) IBOutlet UILabel* year_Value;
@property (strong, nonatomic) IBOutlet UILabel* rated_Value;
@property (strong, nonatomic) IBOutlet UILabel* releasedDate_Value;
@property (strong, nonatomic) IBOutlet UILabel* season_Value;
@property (strong, nonatomic) IBOutlet UILabel* episodenumber_Value;
@property (strong, nonatomic) IBOutlet UILabel* runtime_Value;
@property (strong, nonatomic) UIAlertView *alertView;
@end

