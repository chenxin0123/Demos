//
//  TestObj.h
//  appearanceDemo
//
//  Created by xian on 6/27/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TestObj : UIView

@property (nonatomic, assign) NSInteger count UI_APPEARANCE_SELECTOR ;
@property (nonatomic, strong) UIColor *demoColor UI_APPEARANCE_SELECTOR ;

@end
