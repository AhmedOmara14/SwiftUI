
import Foundation
import SwiftUI

final class MovieRemoteDataSourceImpl : RemoteDataSourceProtocol {
    private var urlSession: URLSession
    private var token: String
    private let baseUrl:String = "https://api.themoviedb.org/3"
    init(urlSession:URLSession = .shared,token: String){
        self.urlSession = urlSession
        self.token = token
    }

    
    func searchMovies(query: String, page: Int) async throws -> MoviesResponseDTO {
        var components = URLComponents(string: baseUrl + "/search/movie")
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        

        let decoded = try JSONDecoder().decode(
            MoviesResponseDTO.self,
            from: data
        )
        
        
        return decoded
        
    }
    
    func fetchMovieDetails(movieId: String) async throws -> MovieDetailsResponseDTO {
        var components = URLComponents(string: baseUrl + "/movie/" + movieId)
       
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        

        let decoded = try JSONDecoder().decode(
            MovieDetailsResponseDTO.self,
            from: data
        )
        
        
        return decoded
        
    }
    
}

