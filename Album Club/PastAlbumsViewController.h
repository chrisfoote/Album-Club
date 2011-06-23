//
//  PastAlbumsViewController.h
//  Album Club
//
//  Created by Cameron Cooke on 16/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PastAlbumsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *albums;
    UITableView *tv;
}

@property (nonatomic, retain) IBOutlet UITableView *tv;

@end
