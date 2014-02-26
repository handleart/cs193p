//
//  Deck.h
//  Matchismo
//
//  Created by Art Mostofi on 2/21/14.
//  Copyright (c) 2014 Art Mostofi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
