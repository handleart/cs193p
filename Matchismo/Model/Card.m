//
//  Card.m
//  Matchismo
//
//  Created by Art Mostofi on 2/21/14.
//  Copyright (c) 2014 Art Mostofi. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
 
    
    return score;
}

@end
