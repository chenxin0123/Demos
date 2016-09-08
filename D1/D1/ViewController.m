//
//  ViewController.m
//  D1
//
//  Created by CX on 7/6/16.
//  Copyright © 2016 cx. All rights reserved.
//

#import "ViewController.h"
#import "D1SizeViewController.h"
#import "D1CookieViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation ViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    _titles = @[@"intrinsicContentSize|sizeThatFits",@"cookies"];
}

#pragma mark - init
#pragma mark - getter / setter
#pragma mark - override
#pragma mark - notification
#pragma mark - action
#pragma mark - network
#pragma mark - private

#pragma mark - tableView

- (void)configTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = self.view.bounds;
        _tableView.rowHeight = 44;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: {
            D1SizeViewController *vc = [D1SizeViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1: {
            D1CookieViewController *vc = [D1CookieViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

@end
