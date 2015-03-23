//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "LetraAViewController.h"

@implementation LetraAViewController

static NSMutableArray *viewArray;
static int counter = 0;

@synthesize palavra,myLabel, botao, next, previous, wordImage, editToolBar, editBarButton,doneBarButton,flexibleSpace, editTextField, nameAux, startPoint, photoBarButton, picker, image, datePicker;

-(void) viewDidLoad {
    [super viewDidLoad];
    [self initialize];

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


//metodo delegate que trata de uitextfielddelegate trata e consegue manter os dados do text field;
-(bool)textFieldShouldReturn:(UITextField *)textField
{
    nameAux = [editTextField text];
    [myLabel setText: nameAux];
    [textField resignFirstResponder];
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [editTextField resignFirstResponder];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *myTouch = [touches anyObject];
    //colocando no centro
    startPoint = [myTouch locationInView:self.view];
    wordImage.center = CGPointMake(startPoint.x, startPoint.y);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [wordImage setFrame:CGRectMake(UIImageViewX,UIImageViewY ,UIImageViewWIDTH ,UIImageViewHEIGHT)];
}

//UIImagePickerDelegate methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [wordImage setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - auxiliary methods

-(void)initialize
{
    viewArray = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    
    nameAux = @" ";
    
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
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
    
    //setando a  toolbar
    editToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 470, 320, 50)];
    
    editBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(buttonManager:)];
    [editBarButton setTag:0];
    
    
    
    
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:editBarButton,nil];
    [editToolBar setItems:buttonArray animated:YES];
    
    [self.view addSubview:editToolBar];
    
    
    
    //setando a palavra
    myLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, 100, 50)];
    [myLabel setText:[[[[self palavra]palavrasArray]objectAtIndex:counter
                       ]palavra]];
    [myLabel setTextColor:[UIColor redColor]];
    NSLog(@"%@", [[[[self palavra]palavrasArray]objectAtIndex:counter]palavra]);
    [self addSubviewWithZoomInAnimation:myLabel duration:1.0 option:UIViewAnimationOptionCurveLinear];
    
    //setando o textField
    editTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, labelY, 320, 50)];
    [editTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [editTextField setHidden:YES];
    [editTextField setDelegate:self];
    [self.view addSubview:editTextField];
    
    //setando a imagem
    wordImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[[[[self palavra]palavrasArray]objectAtIndex:counter]imagem]]];
    //[wordImage setFrame:CGRectMake(40, 100, 250, 300)];
    [wordImage setFrame:CGRectMake(UIImageViewX, UIImageViewY, UIImageViewWIDTH, UIImageViewHEIGHT)];
    [self addSubviewWithZoomInAnimation:wordImage duration:1.0 option:UIViewAnimationOptionCurveEaseInOut];
    
    
    //configurando a gesture para a uiview
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gestureManager:)];
    longPressGestureRecognizer.minimumPressDuration = 2.0f;
    [wordImage addGestureRecognizer:longPressGestureRecognizer];
    [wordImage setUserInteractionEnabled:YES];
    //não esquecer essar interaction enabled.
    
    
    
    NSLog(@"contador estatico: %d", counter);
    
    
}

//metodo que retorna a primeira letra da palavra
-(NSString *)character:(NSString *)novaPalavra
{
    NSString *aux = [NSString stringWithFormat:@"%c", [novaPalavra characterAtIndex:0]];
    return aux;
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

-(void)imageViewZoomInAnimation:(float)duration option:(UIViewAnimationOptions)option
{
    //
    CGAffineTransform trans = CGAffineTransformScale(wordImage.transform, 1,1);
    wordImage.transform = trans;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         wordImage.transform = CGAffineTransformScale(wordImage.transform, 1.25, 1.25);
                     }
                     completion:nil];
    
}

-(void)imageViewZoomOutAnimation:(float)duration option:(UIViewAnimationOptions)option
{
    //
    CGAffineTransform trans = CGAffineTransformScale(wordImage.transform, 1.0,1.0);
    wordImage.transform = trans;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         wordImage.transform = CGAffineTransformScale(wordImage.transform, 0.8, 0.8);
                     }
                     completion:nil];
    
}



//gerencia as gestures
-(void)gestureManager:(UIGestureRecognizer *)sender
{
    if([sender isKindOfClass:[UILongPressGestureRecognizer class]])
        if([sender state] == UIGestureRecognizerStateBegan)
            [self imageViewZoomInAnimation:1.0 option:UIViewAnimationOptionAllowAnimatedContent];
    
            //[wordImage setFrame:CGRectMake(UIImageViewZoomX, UIImageViewZoomY, UIImageViewZoomWIDTH, UIImageViewZoomHEIGHT)];
            
    
        if([sender state] ==  UIGestureRecognizerStateEnded)
        {
            [self imageViewZoomOutAnimation:1.0 option:UIViewAnimationOptionAllowAnimatedContent];
            //[wordImage setFrame:CGRectMake(UIImageViewX, UIImageViewY, UIImageViewWIDTH, UIImageViewHEIGHT)];
        }

}

//gerencia os botoes
-(void)buttonManager:(UIBarButtonItem*) sender
{
    if(sender.tag == 0)
    {
        [self.editToolBar removeFromSuperview];
        [editTextField setHidden:NO];
        editToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 470, 320, 50)];
        
        editBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(buttonManager:)];
        [editBarButton setTag:0];
        
        photoBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(buttonManager:)];
        [photoBarButton setTag:2];
        
        doneBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonManager:)];
        [doneBarButton setTag:1];
        
        flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        NSArray *buttonArray = [[NSArray alloc]initWithObjects:editBarButton, flexibleSpace, photoBarButton, flexibleSpace, doneBarButton ,nil];
        [editToolBar setItems:buttonArray animated:YES];
        
        [self.view addSubview:editToolBar];
        
        datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, UIImageViewY, UIImageViewWIDTH, UIImageViewHEIGHT)];
        [wordImage setHidden:YES];
        [self.view addSubview:datePicker];
        
        NSDate *date = [self.datePicker date];
        [palavra setDataAtual: date];
        NSLog(@"data atual: %@", date);
        
        
    }
    if(sender.tag ==1)
    {
        editToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 470, 320, 50)];
        
        editBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(buttonManager:)];
        [editBarButton setTag:0];
        
        NSArray *buttonArray = [[NSArray alloc]initWithObjects:editBarButton,nil];
        [editToolBar setItems:buttonArray animated:YES];
        
        [self.view addSubview:editToolBar];
        [editTextField setHidden:YES];
        
        
        [wordImage setHidden:NO];
        [datePicker setHidden:YES];
        
        
        
        
    }
    
    if(sender.tag == 2)
    {
        picker = [[UIImagePickerController alloc]init];
        [picker setDelegate: self];
        picker.allowsEditing = YES;
        [picker setSourceType: UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
}



-(void)next:(id)sender {
    [self pushViewManager];
}


-(void)previous:(id)sender
{
    [self popViewManager];
}



-(void)pushViewManager
{
    if(counter >= 23)
    {
        counter = 0;
    }
    else
    {
        counter++;
        
    }
        LetraAViewController *nextViewController = [[LetraAViewController alloc]
                                                    initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

-(void)popViewManager
{
    if(counter == 0)
        counter = 23;
    else
    {
        counter --;
    }
    
    LetraAViewController *previousViewController = [[LetraAViewController alloc]initWithNibName:nil bundle:nil];
    self.navigationController.viewControllers = @[previousViewController, self];
    [self.navigationController popViewControllerAnimated:YES];
}




@end
