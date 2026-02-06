
import Foundation

enum ViewState<T> {
    case idle
    case loading
    case loaded(T)
    case failure(String)
}


