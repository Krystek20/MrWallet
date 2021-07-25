import Foundation
import Combine

protocol MasterdataInteractorType {
    func loadMasterdata(loadableSubject: LoadableSubject<MasterdataAttributes>)
}

struct MasterdataInteractor: MasterdataInteractorType {
    
    // MARK: - Properties
    
    private let repository: Repository
    
    // MARK: - Initialization
    
    init(repository: Repository = MasterdataRepository()) {
        self.repository = repository
    }

    // MARK: - Public
    
    func loadMasterdata(loadableSubject: LoadableSubject<MasterdataAttributes>) {
        loadableSubject.value = .loading
        _ = repository.load()
            .map { $0.data.attributes }
            .sinkToLoadable { loadableSubject.value = $0 }
    }
}

