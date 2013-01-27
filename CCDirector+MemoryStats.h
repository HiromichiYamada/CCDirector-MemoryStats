//
//  CCDirector+MemoryStats.h
//
//  Created by Torques Inc. on 2013/01/27.
//

#import "CCDirector.h"

@interface CCDirector (MemoryStats)

// getAvailable* methods from Halt
// http://craft-notes.com/iphone/cocos2d/cocos2d%E3%81%A7%E6%AE%8B%E3%82%8A%E3%83%A1%E3%83%A2%E3%83%AA%E8%A1%A8%E7%A4%BA/

+ (double) getAvailableBytes;
+ (double) getAvailableKiloBytes;
+ (double) getAvailableMegaBytes;

// getMemoryActive* methods from shinichi
// http://iphone-labo.blogspot.jp/2012/12/cocos2d.html

+ (double) getMemoryActiveBytes;
+ (double) getMemoryActiveKiloBytes;
+ (double) getMemoryActiveMegaBytes;


@end
