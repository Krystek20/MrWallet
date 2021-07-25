import XCTest
import Combine
@testable import MrWallet

final class MasterdataInteractorTests: XCTestCase {

    private var sut: MasterdataInteractor!
    private var repository: MasterdataRepositoryMock!
    private var bindings = Set<AnyCancellable>()
    
    override func setUp() {
        repository = MasterdataRepositoryMock(info: .fixture)
        sut = MasterdataInteractor(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        sut = nil
        bindings.removeAll()
    }
    
    func testLoadMasterDataCallRepositoryOneTime() {
        // given
        let subject = LoadableSubject<MasterdataAttributes>(.notRequested)
        
        // when
        sut.loadMasterdata(loadableSubject: subject)
        
        // then
        XCTAssertEqual(repository.loadCounter, 1)
    }
    
    func testLoadMasterDataSetLoadingAndLoadedStates() {
        // given
        let subject = LoadableSubject<MasterdataAttributes>(.notRequested)
        
        var states = [LoadingState<MasterdataAttributes>]()
        subject
            .sink(receiveValue: {
                states.append($0)
            })
            .store(in: &bindings)
        
        // when
        sut.loadMasterdata(loadableSubject: subject)
        
        // then
        XCTAssertEqual(states, [.notRequested, .loading, .loaded(.fixture)])
    }
}
