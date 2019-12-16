//
//  NSTouchBar.h
//  TouchBarDisplayTest
//
//  Created by Adam Marcus on 15/12/2019.
//  Copyright © 2019 Adam Marcus. All rights reserved.
//

#ifndef NSTouchBar_h
#define NSTouchBar_h

#import <AppKit/AppKit.h>

extern void DFRSystemModalShowsCloseBoxWhenFrontMost(BOOL);

@interface NSTouchBar ()
+ (void)presentSystemModalTouchBar:(nullable NSTouchBar *)touchBar placement:(long long)placement systemTrayItemIdentifier:(nullable NSTouchBarItemIdentifier)identifier;
@end

#endif /* NSTouchBar_h */
