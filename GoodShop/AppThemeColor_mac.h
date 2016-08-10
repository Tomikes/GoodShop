//
//  AppThemeColor.h
//  GoodShop
//
//  Created by mike on 5/12/16.
//  Copyright © 2016 mike. All rights reserved.
//

#ifndef AppThemeColor_h
#define AppThemeColor_h

//theme

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#undef  RGBACOLOR
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#undef	HEX_RGB
#define HEXString_COLOR(V)		[UIColor colorWithHexString:V]


#define GS_TableBarSelectColor  [UIColor colorWithHexString:@"bf1616"]
#define GS_TableBarDefaultColor [UIColor colorWithHexString:@"979c9c"]

#define GS_BackgroundColor      [UIColor colorWithHexString:@"979c9c"]
#define GS_FontColor            [UIColor colorWithHexString:@"2a2c2b"]
#define GS_LightBule            [UIColor colorWithHexString:@"3498db"]
#define GS_Whitle               [UIColor colorWithHexString:@"ecf0f1"]
#define GS_LightRed             [UIColor colorWithHexString:@"e74c3c"]

//button
#define GS_Purple               [UIColor colorWithHexString:@"2e0927"]
#define GS_Red                  [UIColor colorWithHexString:@"d90000"]
#define GS_Qingse               [UIColor colorWithHexString:@"45bf55"]
#define GS_Yellow               [UIColor colorWithHexString:@"ff8c00"]
#define GS_green                [UIColor colorWithHexString:@"04756f"]




#endif /* AppThemeColor_h */
