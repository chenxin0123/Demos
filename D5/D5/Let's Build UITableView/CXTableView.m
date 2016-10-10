//
//  CXTableView.m
//  D5
//
//  Created by CX on 10/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#import "CXTableView.h"
#import "CXTableViewCell.h"

@interface CXTableView ()

@property (nonatomic, strong) NSMutableArray *reuseCells;

@end


@implementation CXTableView

@dynamic delegate;

- (CXTableViewCell *)dequeueReusableCellWithIdentifier: (NSString*) reuseIdentifier {
    CXTableViewCell *cell = nil;
    for (CXTableViewCell *one in self.reuseCells) {
        if ([one.reuseIdentifier isEqualToString:reuseIdentifier]) {
            cell = one;
            break;
        }
    }
    
    if (cell) {
        [self.reuseCells removeObject:cell];
    }
    
    return cell;
}

@end
