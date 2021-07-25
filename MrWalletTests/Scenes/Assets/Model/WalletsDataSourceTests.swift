import XCTest
@testable import MrWallet

final class WalletsDataSourceTests: XCTestCase {

    private var sut: WalletsDataSource!
    private var tableView: UITableView!
    
    override func setUp() {
        tableView = UITableView()
        tableView.register(cell: WalletViewCell.self)
        tableView.register(cell: FiatWalletViewCell.self)
        
        sut = WalletsDataSource()
        sut.walletGroups = [
            .fixture(cellType: .standard),
            .fixture(cellType: .decorated)
        ]
    }
    
    func testNumberOfSectionsReturnsTwo() {
        // when
        let sections = sut.numberOfSections(in: tableView)
        
        // then
        XCTAssertEqual(sections, 2)
    }
    
    func testNumberOfRowsInSectionReturnsTwo() {
        // when
        let rows = sut.tableView(tableView, numberOfRowsInSection: .zero)
        
        // then
        XCTAssertEqual(rows, 2)
    }
    
    func testTitleForHeaderInSectionReturnsTitle() {
        // when
        let title = sut.tableView(tableView, titleForHeaderInSection: .zero)
        
        // then
        XCTAssertEqual(title, WalletGroup.fixture(cellType: .standard).name)
    }
    
    func testCellForRowAtReturnWalletViewCellForStandardType() {
        // when
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: .zero, section: .zero))
        
        // then
        XCTAssertTrue(cell is WalletViewCell)
    }
    
    func testCellForRowAtReturnFiatWalletViewCellForDecoratedType() {
        // when
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: .zero, section: 1))
        
        // then
        XCTAssertTrue(cell is FiatWalletViewCell)
    }
}
