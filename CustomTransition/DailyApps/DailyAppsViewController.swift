//
//  DailyAppsViewController.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

final class DailyAppsViewController: UIViewController {
    // MARK: - Properties

    let transitionManager: UIViewControllerTransitioningDelegate
    
    var cellViewModels: [DailyAppsCardViewModel]

    private var tableView: UITableView

    // MARK: - Initializers

    init() {
        self.tableView = .init()
        self.cellViewModels = []
        self.transitionManager = TransitionManager()

        super.init(
            nibName: nil,
            bundle: nil
        )

        setupTableView()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        cellViewModels = [
            .init(
                image: .init(named: "ic-card1"),
                subtitle: "Наше любимое",
                title: "Пятерка свежих игр",
                description: "Попробуйте эти новинки",
                presentationType: .card
            ),
            .init(
                image: .init(named: "ic-card2"),
                subtitle: "На новый уровень",
                title: "Побеждайте в Project/Cars GO",
                description: "Занимайте первые места с помощью профи",
                presentationType: .card
            ),
            .init(
                image: .init(named: "ic-card3"),
                subtitle: "Для детей",
                title: "Оберегайте других",
                description: "Научите детей ухаживать за живыми существами",
                presentationType: .card
            ),
            .init(
                image: .init(named: "ic-card4"),
                subtitle: "Ситуация",
                title: "Найдите любовь",
                description: "Встречайтесь с новыми людьми",
                presentationType: .card
            ),
        ]
    }

    // MARK: - Pulic Functions

    func getSelectedCard() -> DailyAppsCardView {
        guard
            let indexPath = tableView.indexPathForSelectedRow,
            let cell = tableView.cellForRow(at: indexPath) as? DailyAppsCardCell
        else {
            return .init()
        }

        return cell.cardView
    }

    // MARK: - Private Functions

    private func setupView() {
        view.backgroundColor = .white

        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurEffectView)

        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func setupTableView() {
        setupTableViewAppearance()
        setupTableViewConstraints()
    }

    private func setupTableViewAppearance() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            DailyAppsCardCell.self,
            forCellReuseIdentifier: DailyAppsCardCell.identifier
        )
    }

    private func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
