//
//  Palavras.h
//  Navigation
//
//  Created by Rafael  Hieda on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Palavras : NSObject

@property NSString *palavra, *imagem;
@property NSArray *palavrasArray;


-(id)initWithPalavra:(NSString *)novaPalavra novaImagem:(NSString *)novaImagem;

+(id)sharedInstance;

-(NSArray *) initializedArray;

@end
