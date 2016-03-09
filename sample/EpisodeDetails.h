//
//  EpisodeDetails.h
//  sample
//
//  Created by Roopesh on 3/8/16.
//  Copyright © 2016 roopesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EpisodeDetails : NSObject
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * imdbID;
@property (strong, nonatomic) NSString * dateReleased;
@property (strong, nonatomic) NSString * season;
@property (strong, nonatomic) NSString * episode;
@property (strong, nonatomic) NSString * runtime;
@property (strong, nonatomic) NSString * rated;
@property (strong, nonatomic) NSString * year;
@end
