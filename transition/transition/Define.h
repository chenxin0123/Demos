//
//  Define.h
//  transition
//
//  Created by xian on 5/15/16.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define CXContainerTransitionEndNotification  @"Notification.ContainerTransitionEnd.seedante"
#define CXInteractionEndNotification @"Notification.InteractionEnd.seedante"

typedef NS_ENUM(NSInteger, CXTransitionType) {
    CXNavigationControllerOperationPush,
    CXNavigationControllerOperationPop,
    CXTabOperationDirectionLeft,
    CXTabOperationDirectionRight,
    CXModalOperationPresentaion,
    CXModalOperationDismissal
};


#endif /* Define_h */
