
protocol SearchMoviesUseCase{
    func execute(query:String, page:Int) async throws -> [Movie]
}

final class DefaultSearchMoviesUseCase:SearchMoviesUseCase{
    let repository:MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func execute(query: String, page: Int) async throws -> [Movie] {
        return try await repository.searchMovies(query: query, page: page)
    }
     
    
}
