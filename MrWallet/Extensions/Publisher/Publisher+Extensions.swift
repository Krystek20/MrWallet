import Foundation
import Combine

extension Publisher where Self.Failure == Never {
    func assignNoRetain<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }

    func assignNoRetain<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output?>, on object: Root) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}

extension Publisher {
    func sinkToLoadable(_ completion: @escaping (LoadingState<Output>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { subscriptionCompletion in
            guard case .failure(let error) = subscriptionCompletion else { return }
            completion(.failed(error))
        }, receiveValue: { value in
            completion(.loaded(value))
        })
    }
}
