//
//
//  Navigation
//
//  Created by Rafael  Hieda on 21/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "PalavraSingleton.h"

@implementation PalavraSingleton
//
//static PalavraSingleton *singleton = nil;;
//static bool isFirstAccess = YES;
//
//+ (id)sharedInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        isFirstAccess = NO;
//        singleton = [[super allocWithZone:NULL] init];
//    });
//    
//    return singleton;
//}
//
//-(void)inserir:(Palavras *)palavras
//{
//    RLMRealm *myRealm = [RLMRealm defaultRealm];
//    [myRealm beginWriteTransaction];
//    [myRealm addObject:palavras];
//    [myRealm commitWriteTransaction];
//}
//
//-(void)atualizar:(Palavras *)palavras
//{
//    
//}
//
//-(NSArray *)todasPalavras
//{
//    //retiro do banco de dados as palavras e depois passo para este array
//    RLMResults *realmResults = [Palavras allObjects];
//    NSMutableArray *resultsArray = [[NSMutableArray alloc]initWithCapacity: realmResults.count];
//    
//    for(Palavras *p in realmResults)
//    {
//        [resultsArray addObject:p];
//    }
//    
//    return resultsArray;
//}


@end
