
protocol GetAllMoviesUseCase{
    func execute(query:String, page:Int) async throws -> [Movie]
}

final class DefaultGetAllMoviesUseCase:GetAllMoviesUseCase{
    let repository:MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func execute(query: String, page: Int) async throws -> [Movie] {
        return try await repository.searchMovies(query: query, page: page)
    }
     
    
}
