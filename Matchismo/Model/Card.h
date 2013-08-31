//
//  Card.h
//  Matchismo
//
//  Created by Zarick on 24/8/13.
//  Copyright (c) 2013 Zarick's Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isPlayable) BOOL playable;

- (NSString *)contents;

- (int)match:(NSArray *)cards;

@end
