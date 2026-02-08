
protocol GetMovieDetailsUseCase{
    func execute(movieId:String) async throws -> MovieDetails
}

final class DefaultGetMovieDetailsUseCase:GetMovieDetailsUseCase{
    let repository:MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func execute(movieId: String) async throws -> MovieDetails {
        return try await repository.fetchMovieDetails(movieId: movieId)
    }
     
}
