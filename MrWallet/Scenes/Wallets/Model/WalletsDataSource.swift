import UIKit.UITableView

final class WalletsDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    var walletGroups: [WalletGroup] = []
    
    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        walletGroups.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        walletGroups[safe: section]?.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        walletGroups[safe: section]?.walletViewModels.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let walletGroup = walletGroups[safe: indexPath.section],
              let viewModel = walletGroup.walletViewModels[safe: indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(cellType(for: walletGroup.cellType), for: indexPath)
        guard let walletAssetCell = cell as? WalletCell else { return cell }
        walletAssetCell.viewModel = viewModel
        return walletAssetCell
    }
    
    // MARK: - Private
    
    private func cellType(for type: WalletCellType) -> UITableViewCell.Type {
        switch type {
        case .standard: return WalletViewCell.self
        case .decorated: return FiatWalletViewCell.self
        }
    }
}
