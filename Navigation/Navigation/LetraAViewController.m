//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "LetraAViewController.h"
#import "LetraBViewController.h"


@implementation LetraAViewController

static NSMutableArray *viewArray;
static int counter = 0;

@synthesize palavra,myLabel, botao, next, previous, wordImage, tabBar;

-(void) viewDidLoad {
    [super viewDidLoad];
    [self initialize];

}

-(void)next:(id)sender {
//    LetraAViewController *proximo = [[LetraAViewController alloc]
//                                              initWithNibName:nil
//                                            bundle:NULL];
// [self.navigationController pushViewController:proximo animated:YES];
    [self.navigationController pushViewController:[self viewManager] animated:YES];
}


-(void)previous:(id)sender
{
 //   [self popViewControllerManager];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)initialize
{

    
    viewArray = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];

    
    if(counter >= 24)
    {
        counter = 0;
    }
    
    
    
    //instancia a classe palavra
    palavra = [[Palavras alloc]init];
    //verifica se ela foi criada, se não ela gera o array populado com as palavras
    if([palavra palavrasArray] == nil)
       [[self palavra]initializedArray];
   
    
    
    
    //setando os botões e o título  da navigation bar
    
     self.title = [self character: [[[[self palavra]palavrasArray]objectAtIndex:counter]palavra]];
    
    next = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem=next;
    
    previous = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(previous:)];
    self.navigationItem.leftBarButtonItem = previous;
    
    
    //setando a tab bar
    
    tabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 518, 320, 20)];
    //não estou convicto desta tag aqui, preciso dar uma olhada
    UITabBarItem *dictionaryView = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
    UITabBarItem *tableView = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    tabBar.items = @[dictionaryView, tableView];
    [tabBar setItems: tabBar.items];
    [tabBar setItemPositioning:UITabBarItemPositioningAutomatic];
    
    
    
    [self.view addSubview:tabBar];
    
    

    
    //setando o conteúdo da view
    myLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelWIDTH, labelHEIGHT)];
    [myLabel setText:[[[[self palavra]palavrasArray]objectAtIndex:counter
                       ]palavra]];
    [myLabel setTextColor:[UIColor redColor]];
     NSLog(@"%@", [[[[self palavra]palavrasArray]objectAtIndex:counter]palavra]);
    [self addSubviewWithZoomInAnimation:myLabel duration:2.0 option:UIViewAnimationOptionCurveLinear];
    
    
    wordImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[[[[self palavra]palavrasArray]objectAtIndex:counter]imagem]]];
    //[wordImage setFrame:CGRectMake(40, 100, 250, 300)];
    [wordImage setFrame:CGRectMake(UIImageViewX, UIImageViewY, UIImageViewWIDTH, UIImageViewHEIGHT)];
    [self addSubviewWithZoomInAnimation:wordImage duration:2.0 option:UIViewAnimationOptionCurveEaseInOut];
    
    
    
    
    //configurando a gesture para a uiview
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gestureManager:)];
    longPressGestureRecognizer.minimumPressDuration = 3.0f;
    [wordImage addGestureRecognizer:longPressGestureRecognizer];
    [wordImage setUserInteractionEnabled:YES];
    //não esquecer essar interaction enabled.
    
    
    counter++;
    NSLog(@"contador estatico: %d", counter);
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.botao setHidden:YES];
    [self.myLabel setHidden:YES];
    [wordImage setHidden:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.botao setHidden:NO];
    [self.myLabel setHidden:NO];
    [self.wordImage setHidden:NO];
}



#pragma mark - auxiliary methods

-(NSString *)character:(NSString *)novaPalavra
{
    NSString *aux = [NSString stringWithFormat:@"%c", [novaPalavra characterAtIndex:0]];
    return aux;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{

}


//metodo de aparição zoomIn
-(void)addSubviewWithZoomInAnimation:(UIView *)view duration:(float)duration option:(UIViewAnimationOptions)option
{
    //
    CGAffineTransform trans = CGAffineTransformScale(view.transform, 0.01,0.01);
    view.transform = trans;
    [self.view addSubview:view];
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         view.transform = CGAffineTransformScale(view.transform, 100.0, 100.0);
                     }
                     completion:nil];
    
}

-(void)gestureManager:(UIGestureRecognizer *)sender
{
    if([sender isKindOfClass:[UILongPressGestureRecognizer class]])
        if([sender state] == UIGestureRecognizerStateBegan)
            [wordImage setFrame:CGRectMake(UIImageViewX, UIImageViewY, 300, 350)];
    
        if([sender state] ==  UIGestureRecognizerStateEnded)
        {
            [wordImage setFrame:CGRectMake(UIImageViewX, UIImageViewY, UIImageViewWIDTH, UIImageViewHEIGHT)];
        }

}

//metodo que controla o empilhamento das views.
-(LetraAViewController *)viewManager
{
    NSLog(@"antes de empilhar: %lu", viewArray.count);
    
        //tratamento utilizando as três views, desempilhando sempre a primeira e empurrando as restantes um índice abaixo
        if(viewArray.count == 3)
        {
            NSLog(@"entrei counter == 3");
            [viewArray removeObjectAtIndex:0];
            NSLog(@"verificando se ele desempilhou de fato: %lu", viewArray.count);
            LetraAViewController *proximo = [[LetraAViewController alloc]initWithNibName:nil bundle:nil];
//            NSLog(@"quantidade atual de posicoes: %lu", [viewArray count]);
            self.navigationController.viewControllers = viewArray;
            [viewArray addObject:proximo];
            return [viewArray lastObject];
        }
    //adiciona a segunda view no array de views
    else if(viewArray.count == 2)
    {
        LetraAViewController *proximo = [[LetraAViewController alloc]initWithNibName:nil bundle:nil];
        [viewArray addObject:proximo];
        return [viewArray lastObject];
    }
    
    //ao iniciar ele só adiciona mais um ao array de views.
    else if(viewArray.count  == 1)
    {
        LetraAViewController *proximo = [[LetraAViewController alloc]initWithNibName:nil bundle:nil];
        [viewArray addObject:proximo];
        return [viewArray lastObject];
    }
    
    
    return nil;
        
}

-(LetraAViewController *)popViewControllerManager
{
    if(viewArray.count == 3)
    {
        [self.navigationController popViewControllerAnimated:YES];
        int auxCounter = counter;
        NSLog(@"entrei counter == 3");
        
        [viewArray addObject:[viewArray objectAtIndex:1]];
        NSLog(@"verificando se ele desempilhou de fato: %lu", viewArray.count);
        
        [viewArray replaceObjectAtIndex:1 withObject:[viewArray objectAtIndex:0]];
        
        counter = counter - 2;
        LetraAViewController *anterior = [[LetraAViewController alloc]initWithNibName:nil bundle:nil];
        [viewArray insertObject:anterior atIndex:0];
        
        //            NSLog(@"quantidade atual de posicoes: %lu", [viewArray count]);
        self.navigationController.viewControllers = viewArray;
        return [viewArray lastObject];
        counter = auxCounter;
    }
    
    //adiciona a segunda view no array de views
    else if(viewArray.count == 2)
    {
        LetraAViewController *posterior = [[LetraAViewController alloc]initWithNibName:nil bundle:nil];
        [viewArray addObject:posterior];
        return [viewArray lastObject];
    }
    
    //ao iniciar ele só adiciona mais um ao array de views.
    else if(viewArray.count  == 1)
    {
        LetraAViewController *anterior = [[LetraAViewController alloc]initWithNibName:nil bundle:nil];
        [viewArray addObject:anterior];
        return [viewArray lastObject];
    }
    
    return nil;
}


@end
