import SwiftUI

@MainActor
final class DetailsViewModel: ObservableObject {
    @Published private(set) var state: ViewState<MovieDetails> = .idle
    

    private let movieDetialsUseCase: GetMovieDetailsUseCase
    
    private let router: AppRouter

    init(movieDetialsUseCase: GetMovieDetailsUseCase, appRouter: AppRouter) {
        self.movieDetialsUseCase = movieDetialsUseCase
        self.router = appRouter
    }
    
    func onBackPressure() {
        router.navigateBack()
    }

  
    func fetchMovieDetials(movieId:String) async {
        state = .loading
        
        do {
            let movie = try await movieDetialsUseCase.execute(movieId: movieId)
            state = .loaded(movie)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

}
