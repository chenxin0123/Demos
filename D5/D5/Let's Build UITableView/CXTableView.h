//
//  CXTableView.h
//  D5
//
//  Created by CX on 10/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXTableView;

@protocol CXTableViewDelegate <NSObject, UIScrollViewDelegate>

- (CGFloat)CXTableView:(CXTableView *)tableView heightForRow:(NSInteger)row;

@end

@interface CXTableView : UIScrollView

@property (nonatomic, weak) id<CXTableViewDelegate> delegate;

@end
