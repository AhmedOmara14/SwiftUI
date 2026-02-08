
public protocol RemoteDataSourceProtocol{
    func searchMovies(query: String, page:Int) async throws -> MoviesResponseDTO
    
    func fetchMovieDetails(movieId: String) async throws -> MovieDetailsResponseDTO
}
