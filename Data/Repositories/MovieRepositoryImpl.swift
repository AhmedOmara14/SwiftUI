import SwiftUI

final class MovieRepositoryImpl: MovieRepository {
  
    
    private let remoteDataSource: RemoteDataSourceProtocol
    
    init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func searchMovies(query: String, page: Int) async throws -> [Movie] {
        let dtos = try await remoteDataSource.searchMovies(query: query, page: page)
        
        return dtos.results.map(MovieMapper.map)
    }
    
    func fetchMovieDetails(movieId: String) async throws -> MovieDetails {
        let dtos = try await remoteDataSource.fetchMovieDetails(movieId: movieId)
        
        
        return MovieDetailsMapper.map(dtos)
    }
    
}
