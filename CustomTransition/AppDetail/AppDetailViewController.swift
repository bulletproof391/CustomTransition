//
//  AppDetailViewController.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

class AppDetailViewController: UIViewController {
    // MARK: - Properties

    override var prefersStatusBarHidden: Bool {
        return true
    }

    let cardViewModel: DailyAppsCardViewModel

    private var appViewDetail: AppDetailView {
        view as! AppDetailView
    }

    // MARK: - Initializer

    init(_ cardViewModel: DailyAppsCardViewModel) {
        self.cardViewModel = cardViewModel

        super.init(
            nibName: nil,
            bundle: nil
        )

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Life Cycle

    override func loadView() {
        view = AppDetailView(cardViewModel)
    }

    // MARK: - Public Functions

    func updateConstraintsToFullMode() {
        appViewDetail.updateConstraintsToFullMode()
    }

    func updateConstraintsToCardMode() {
        appViewDetail.updateConstraintsToCardMode()
    }

    // MARK: - Private Functions

    private func setup() {
        setupButton()
    }

    private func setupButton() {
        appViewDetail.closeButton.addTarget(
            self,
            action: #selector(didSelectClose),
            for: .touchUpInside
        )
    }

    @objc
    private func didSelectClose() {
        dismiss(animated: true)
    }
}
