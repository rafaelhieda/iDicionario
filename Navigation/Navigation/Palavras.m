//
//  Palavras.m
//  Navigation
//
//  Created by Rafael  Hieda on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "Palavras.h"

@implementation Palavras

@synthesize palavra,imagem, palavrasArray;

static bool isFirstAccess = YES;
static Palavras *singleton = nil;

-(id)initWithPalavra:(NSString *)novaPalavra novaImagem:(NSString *)novaImagem
{
    self = [super init];
    if(self)
    {
        palavra = novaPalavra;
        imagem = novaImagem;
    }
    return self;
}

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                      isFirstAccess = NO;
        singleton = [[super allocWithZone:NULL]init];
    });
    
    return singleton;
}


-(NSArray *)initializedArray
{
    palavrasArray = [[NSArray alloc]initWithObjects:
                     [[Palavras alloc]initWithPalavra:@"Avestruz" novaImagem:@"avestruz.png"],
                     [[Palavras alloc]initWithPalavra:@"Burro" novaImagem:@"burro.png"],
                     [[Palavras alloc]initWithPalavra:@"Coelho" novaImagem:@"coelho.png"],
                     [[Palavras alloc]initWithPalavra:@"Doninha" novaImagem:@"doninha.png"],
                     [[Palavras alloc]initWithPalavra:@"Esquilo" novaImagem:@"esquilo.png"],
                     [[Palavras alloc]initWithPalavra:@"Foca" novaImagem:@"foca.png"],
                     [[Palavras alloc]initWithPalavra:@"Golfinho" novaImagem:@"golfinho.png"],
                     [[Palavras alloc]initWithPalavra:@"Hipopotamo" novaImagem:@"hipopotamo.png"],
                     [[Palavras alloc]initWithPalavra:@"Iguana" novaImagem:@"iguana.png"],
                     [[Palavras alloc]initWithPalavra:@"Jacaré" novaImagem:@"jacare.png"],
                     [[Palavras alloc]initWithPalavra:@"Kiwi" novaImagem:@"kiwi.png"],
                     [[Palavras alloc]initWithPalavra:@"Leão" novaImagem:@"leao.png"],
                     [[Palavras alloc]initWithPalavra:@"Morcego" novaImagem:@"morcego.png"],
                     [[Palavras alloc]initWithPalavra:@"Naja" novaImagem:@"naja.png"],
                     [[Palavras alloc]initWithPalavra:@"Ovelha" novaImagem:@"ovelha.png"],
                     [[Palavras alloc]initWithPalavra:@"Porco" novaImagem:@"porco.png"],
                     [[Palavras alloc]initWithPalavra:@"Quati" novaImagem:@"quati.png"],
                     [[Palavras alloc]initWithPalavra:@"Raposa" novaImagem:@"raposa.png"],
                     [[Palavras alloc]initWithPalavra:@"Sapo" novaImagem:@"sapo.png"],
                     [[Palavras alloc]initWithPalavra:@"Tamanduá" novaImagem:@"tamandua.png"],
                     [[Palavras alloc]initWithPalavra:@"Urso" novaImagem:@"urso.png"],
                     [[Palavras alloc]initWithPalavra:@"Vaca" novaImagem:@"vaca.png"],
                     [[Palavras alloc]initWithPalavra:@"Ximango" novaImagem:@"ximango.png"],
                     [[Palavras alloc]initWithPalavra:@"Zebra" novaImagem:@"zebra.png"],
                     nil
                     ];
    return palavrasArray;
}




@end
