//
//  MovieView.m
//  MovieDB
//
//  Created by srujan.k on 09/11/17.
//

#import "MovieView.h"
#import "SearchCell.h"

@interface MovieView ()
{
    NSMutableArray *movies;
    NSMutableArray *searchResults;
    NSMutableDictionary *selectedMovie;
    BOOL searchEnabled;
}
@end

@implementation MovieView

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedMovie = [NSMutableDictionary new];
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor whiteColor]];
    
    
    movies=[NSMutableArray new];
    
    searchResults = [NSMutableArray arrayWithArray:movies];
    
}
-(void)viewWillAppear:(BOOL)animated{
    ServerAPI *api= [ServerAPI new];
    api.delegate = self;
    [api getTopRated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Collection View Delegate & Data Source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (searchEnabled) {
        return searchResults.count;
    }
    else
        return [movies count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"SearchCell";
    
    SearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (!searchEnabled) {
        [self removeNoDataFoundImage];
        cell.movieName.text =movies[indexPath.item][@"title"];
        [cell.movieImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w185/%@",movies[indexPath.item][@"poster_path"]]] placeholderImage:[UIImage imageNamed:@"default_poster"]];
    }
    else if (searchEnabled){
        [self removeNoDataFoundImage];
        cell.movieName.text =searchResults[indexPath.item][@"title"];
        [cell.movieImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w185/%@",searchResults[indexPath.item][@"poster_path"]]] placeholderImage:[UIImage imageNamed:@"default_poster"]];
    }
    
    
    cell.layer.masksToBounds = TRUE;
    [cell.layer setCornerRadius:6.0f];
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 1.0f;
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!searchEnabled) {
        if (movies[indexPath.item]) {
            selectedMovie = [NSMutableDictionary dictionaryWithDictionary:movies[indexPath.item]];
            [self performSegueWithIdentifier:@"toMovieDetails" sender:nil];
        }
    }
    else if(searchEnabled){
        if (searchResults[indexPath.item]) {
            selectedMovie = [NSMutableDictionary dictionaryWithDictionary:searchResults[indexPath.item]];
            [self performSegueWithIdentifier:@"toMovieDetails" sender:nil];
        }
    }
    
    
    
}


#pragma mark - API Methods
-(void)topRatedListSucess:(NSArray *)response{
    movies = [NSMutableArray arrayWithArray:response];
    [self.searchCollectionView reloadData];
}
-(void)topRatedListError:(NSError *)error{
    [self alertWithOkBtn:@"Error" EnterMessage:error.localizedDescription];
}

-(void)popularListSucess:(NSArray *)response{
    movies = [NSMutableArray arrayWithArray:response];
    [self.searchCollectionView reloadData];
}
-(void)popularListError:(NSError *)error{
    [self alertWithOkBtn:@"Error" EnterMessage:error.localizedDescription];
}
-(void)searchMovieSucess:(NSArray *)response{
    [self.searchCollectionView setUserInteractionEnabled:TRUE];
    NSLog(@"rep:%@",response);
    if (response.count > 0) {
        searchResults = [NSMutableArray arrayWithArray:response];
        [self.searchCollectionView reloadData];
    }
    else if (response.count == 0){
        [self.searchCollectionView reloadData];
        [self setNoDataFoundImage];
    }
}
-(void)searchMovieError:(NSError *)error{
    [self.searchCollectionView setUserInteractionEnabled:TRUE];
    [self alertWithOkBtn:@"Error" EnterMessage:error.localizedDescription];
}
#pragma mark - Action Methods
- (IBAction)filterAction:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Search Filter" message:@"Filter Movies" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *mostPopular = [UIAlertAction actionWithTitle:@"Popular" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ServerAPI *api= [ServerAPI new];
        api.delegate = self;
        [api getPopular];
        
    }];
    UIAlertAction *highlyRated = [UIAlertAction actionWithTitle:@"Highly Rated" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ServerAPI *api= [ServerAPI new];
        api.delegate = self;
        [api getTopRated];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheet addAction:mostPopular];
    [actionSheet addAction:highlyRated];
    [actionSheet addAction:cancelAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
}



#pragma mark - Search delegate methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length == 0)
    {
        searchResults = movies;
        [searchBar resignFirstResponder];
        [self.searchBar setReturnKeyType:UIReturnKeySearch];
        self.searchBar.enablesReturnKeyAutomatically = NO;
        searchEnabled = YES;
        //        [self filterContentForSearchText:searchBar.text];
    }
    else{
        [searchBar resignFirstResponder];
        searchEnabled = YES;
        //        [self filterContentForSearchText:searchBar.text];
        [self.searchCollectionView setUserInteractionEnabled:FALSE];
        ServerAPI *api = [ServerAPI new];
        api.delegate= self;
        [api searchUsingMovieName:searchBar.text];
        
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
    searchEnabled = NO;
    [self.searchCollectionView reloadData];
}
#pragma mark - Other Methods
-(void)setNoDataFoundImage
{
    // setting background image for table view as no records here because if we keep this any where it will first show no records found image while requesting for service.
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"norecord"]];
    [imageView setContentMode:UIViewContentModeCenter];
    [self.searchCollectionView setBackgroundView:imageView];
    //    self.searchCollectionView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)removeNoDataFoundImage
{
    // setting background image for table view as no records here because if we keep this any where it will first show no records found image while requesting for service.
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor clearColor];
    [imageView setContentMode:UIViewContentModeCenter];
    [self.searchCollectionView setBackgroundView:imageView];
    //    self.searchCollectionView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)alertWithOkBtn:(NSString *)title EnterMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *ok =[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toMovieDetails"]) {
        MovieDetails *details = [segue destinationViewController];
        details.movieDetails = selectedMovie;
    }
}

@end
