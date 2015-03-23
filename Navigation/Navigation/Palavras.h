//
//  Palavras.h
//  Navigation
//
//  Created by Rafael  Hieda on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm/Realm.h"
@interface Palavras : NSObject
//RLMObject
@property NSString *palavra, *imagem;
@property NSArray *palavrasArray;
@property NSDate *dataAtual;

-(id)initWithPalavra:(NSString *)novaPalavra novaImagem:(NSString *)novaImagem;

+(id)sharedInstance;

-(NSArray *) initializedArray;

@end
