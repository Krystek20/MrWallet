import Foundation
import Combine
@testable import MrWallet

final class MasterdataRepositoryMock: Repository {
    
    // MARK: - Properties
    
    private(set) var loadCounter: Int = .zero
    private let info: MasterdataInfo
    
    // MARK: - Initialization
    
    init(info: MasterdataInfo) {
        self.info = info
    }
    
    // MARK: - Public
    
    func load() -> AnyPublisher<MasterdataInfo, Error> {
        loadCounter += 1
        return Just(info)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
