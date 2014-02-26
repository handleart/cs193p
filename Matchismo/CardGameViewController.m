//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Art Mostofi on 2/21/14.
//  Copyright (c) 2014 Art Mostofi. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *deck;
@property (strong, nonatomic) NSString *pcContents;
@property (nonatomic) Card *card;
@end

@implementation CardGameViewController

- (PlayingCardDeck *)deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
    //test
}

-(void)setFlipCount:(int)flipCount {
   _flipCount = flipCount;
   self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
   //NSLog(@"flipCount changed to %d", self.flipCount);
}


- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        _pcContents = [(PlayingCard *)[self.deck drawRandomCard] contents];
        
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        
        if ([_pcContents length] == 0) {
            [sender setTitle:@"?" forState:UIControlStateNormal];
        } else {
            [sender setTitle:_pcContents forState:UIControlStateNormal];
        }
        
        //NSLog(@"Deck object type %@", [self.playingCard contents]);
    }
    self.flipCount++;
}


@end
