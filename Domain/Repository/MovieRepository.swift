//
//  MovieRepository.swift
//  UserPosts
//
//  Created by Omara on 30/01/2026.
//

protocol MovieRepository {
    func searchMovies(query:String,page:Int) async throws -> [Movie]
}
