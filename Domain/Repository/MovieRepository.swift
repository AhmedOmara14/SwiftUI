

protocol MovieRepository {
    func searchMovies(query:String,page:Int) async throws -> [Movie]
    
    func fetchMovieDetails(movieId: String) async throws -> MovieDetails

}
