//
//  GlobalCommon.h
//  Histogram
//
//  Created by lixiangdong on 2017/6/19.
//  Copyright © 2017年 myself. All rights reserved.
//

#ifndef GlobalCommon_h
#define GlobalCommon_h

#define UIColorMakeRGBA(nRed, nGreen, nBlue, nAlpha) [UIColor colorWithRed:(nRed) / 255.0f   \
green:(nGreen) / 255.0f \
blue:(nBlue) / 255.0f  \
alpha:nAlpha]

#define UIColorMakeRGB(nRed, nGreen, nBlue) UIColorMakeRGBA(nRed, nGreen, nBlue, 1.0f)
#define UIColorRGB(color) UIColorMakeRGB(color >> 16, (color & 0x00ff00) >> 8, color & 0x0000ff)
#define UIColorARGB(color) UIColorMakeRGBA((color & 0x00ff0000) >> 16, (color & 0x00ff00) >> 8, color & 0x0000ff, ((color & 0xff000000) >> 24) / 255.0f)


#define UI_IOS_WINDOW_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define UI_IOS_WINDOW_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#endif /* GlobalCommon_h */
