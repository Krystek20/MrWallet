import Foundation
@testable import MrWallet

final class MasterdataInteractorMock: MasterdataInteractorType {
    
    // MARK: - Properties
    
    private(set) var loadMasterdataCounter: Int = .zero
    private(set) var loadableSubjectSet: LoadableSubject<MasterdataAttributes>?
    
    // MARK: - Public
    
    func loadMasterdata(loadableSubject: LoadableSubject<MasterdataAttributes>) {
        loadMasterdataCounter += 1
        loadableSubjectSet = loadableSubject
    }
}
