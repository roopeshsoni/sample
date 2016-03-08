//
//  DetailViewController.h
//  sample
//
//  Created by Roopesh on 3/8/16.
//  Copyright © 2016 roopesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

