//
//  DetailViewController.m
//  sample
//
//  Created by Roopesh on 3/8/16.
//  Copyright © 2016 roopesh. All rights reserved.
//

#import "EpisodeDetailViewController.h"
#define kEpisodeDetailBaseURLFormat @"http://www.omdbapi.com/?i=%@&plot=short&r=json"

@interface EpisodeDetailViewController ()


@end

@implementation EpisodeDetailViewController
@synthesize episodeDetails,alertView;

#pragma mark - Managing the detail item



- (void)configureView {
    // Update the user interface for the detail item.
    if (self.episodeData) {
        // Show progress view till data is Being Downloaded
        self.detailDescriptionLabel.text = self.episodeData.title;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //Your main thread code goes in here
        alertView = [[UIAlertView alloc] initWithTitle:@"Loading data..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicator startAnimating];
        
        [alertView setValue:indicator forKey:@"accessoryView"];
        [alertView show];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        
        
        NSString *episdodeDetailURLString = [NSString stringWithFormat:kEpisodeDetailBaseURLFormat,self.episodeData.imdbID];
        NSURL *episodeDetailURL = [NSURL URLWithString:[episdodeDetailURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSData* data = [NSData dataWithContentsOfURL:
                        episodeDetailURL];
        [self performSelectorOnMainThread:@selector(getEpisodeDetails:)
                               withObject:data waitUntilDone:YES];
        
    });
    [self configureView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchEpisodeListForSeason:(NSString*)seasonNumber{

}
- (void)getEpisodeDetails:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    if (error == nil) {
        
        self.episodeData.year = [json objectForKey:@"Year"];
        self.year_Value.text = self.episodeData.year;
        self.episodeData.rated = [json objectForKey:@"Rated"];
        self.rated_Value.text = self.episodeData.rated;
        self.episodeData.dateReleased = [json objectForKey:@"Released"];
        self.releasedDate_Value.text = self.episodeData.dateReleased;
        self.episodeData.season = [json objectForKey:@"Season"];
        self.season_Value.text = self.episodeData.season;
        self.episodeData.episode = [json objectForKey:@"Episode"];
        self.episodenumber_Value.text = self.episodeData.episode;
        self.episodeData.runtime = [json objectForKey:@"Runtime"];
        self.runtime_Value.text = self.episodeData.runtime;
        
        
        
    }else{
        NSLog(@"Error: %@", [error description]); //3
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //Your main thread code goes in here
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });

}


@end
