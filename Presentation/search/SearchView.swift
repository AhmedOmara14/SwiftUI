//
//  SearchView.swift
//  UserPosts
//
//  Created by Omara on 30/01/2026.
//
import SwiftUI

struct SearchView: View {
    
    @StateObject private var vm: SearchViewModel

    init(viewModel: SearchViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            switch vm.state {
            case .idle:
                ProgressView("Loading…")
                
            case .loading:
                ProgressView("Loading…")
                
            case .loaded(let movies):
                if !movies.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(movies) { movie in
                                MovieCardInfo(movie: movie)
                            }
                        }
                        .padding()
                    }
                } else {
                    Text("No movies found")
                }
                
            case .failure(let error):
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text("Error loading movies")
                        .font(.headline)
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            }
        }
    }
}
