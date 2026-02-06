
final class MovieRepositoryImpl: MovieRepository {
    private let remoteDataSource: RemoteDataSourceProtocol
    
    init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func searchMovies(query: String, page: Int) async throws -> [Movie] {
        let dtos = try await remoteDataSource.searchMovies(query: query, page: page)
        
        return dtos.results.map(MovieMapper.map)
    }
    
    
}
