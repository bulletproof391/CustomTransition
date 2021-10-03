//
//  DailyAppsViewController+UITableViewDelegate.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

extension DailyAppsViewController: UITableViewDelegate {
    // MARK: - Functions

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        var viewModel = cellViewModels[indexPath.row]
        viewModel.presentationType = .full
        let viewController = AppDetailViewController(viewModel)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.transitioningDelegate = transitionManager

        present(
            viewController,
            animated: true
        )
    }
}
