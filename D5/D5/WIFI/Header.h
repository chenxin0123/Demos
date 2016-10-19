//
//  Header.h
//  D5
//
//  Created by xian on 19/10/2016.
//  Copyright © 2016 cx. All rights reserved.
//

#ifndef Header_h
#define Header_h

#ifndef kSystemVersion
#define kSystemVersion ([UIDevice currentDevice].systemVersion.doubleValue)
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

#endif /* Header_h */
