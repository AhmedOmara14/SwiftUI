import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query:String = ""
    @Published private(set) var state: ViewState<[Movie]> = .idle
    
    private let searchUseCase: SearchMoviesUseCase
    private var searchTask: Task<Void, Never>?
    
    init(searchUseCase: SearchMoviesUseCase) {
        self.searchUseCase = searchUseCase
        onQueryChanged("Avatar")
    }
    

    
    func onQueryChanged(_ query: String) {
        self.query = query
        print("[SearchViewModel] onQueryChanged -> query='\(query)' ")
        
        searchTask?.cancel()
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else {
            print("[SearchViewModel] Empty query -> resetting to idle")
            self.state = .idle
            return
        }
        
        searchTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 400_000_000)
            guard let self else { return }
            guard !Task.isCancelled else { return }
            await self.search(page: 1)
        }
    }
    
    func search(page: Int) async {
        guard Task.isCancelled == false else { return }
        state = .loading
        
        do {
            let movies = try await searchUseCase.execute(query: query, page: page)
            state = .loaded(movies)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
