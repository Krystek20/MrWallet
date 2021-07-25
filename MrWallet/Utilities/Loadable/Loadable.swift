import Foundation
import Combine

typealias LoadableSubject<T> = CurrentValueSubject<LoadingState<T>, Never>

enum LoadingState<T> {
    case notRequested
    case loading
    case loaded(T)
    case failed(Error)
}

extension LoadingState {
    var isLoading: Bool {
        guard case .loading = self else { return false }
        return true
    }
    
    var result: T? {
        guard case .loaded(let object) = self else { return nil }
        return object
    }
}

extension LoadingState: Equatable {
    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested): return true
        case (.loading, .loading): return true
        case (.loaded, .loaded): return true
        case (.failed, .failed): return true
        default: return false
        }
    }
}
