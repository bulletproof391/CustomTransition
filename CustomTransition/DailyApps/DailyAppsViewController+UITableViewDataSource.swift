//
//  DailyAppsViewController+UITableViewDataSource.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

extension DailyAppsViewController: UITableViewDataSource {
    // MARK: - Functions

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        cellViewModels.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DailyAppsCardCell.identifier,
            for: indexPath
        ) as? DailyAppsCardCell

        cell?.configure(with: cellViewModels[indexPath.row])

        return cell ?? UITableViewCell()
    }
}
