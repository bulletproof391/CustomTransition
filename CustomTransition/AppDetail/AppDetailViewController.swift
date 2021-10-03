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


final class AppDetailView: UIView {
    // MARK: - Properties

    let cardView: DailyAppsCardView

    let closeButton: UIButton

    private let cardViewModel: DailyAppsCardViewModel

    private let scrollView: UIScrollView

    private let contentView: AppDetailContentView

    // MARK: - Initializer

    init(_ cardViewModel: DailyAppsCardViewModel) {
        self.cardViewModel = cardViewModel
        self.scrollView = .init()
        self.cardView = .init()
        self.contentView = .init()
        self.closeButton = .init(type: .custom)

        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Functions

    func updateConstraintsToFullMode() {
        cardView.updateConstraintsToFullMode()
    }

    func updateConstraintsToCardMode() {
        cardView.updateConstraintsToCardMode()
    }

    // MARK: - Private Functions

    private func setup() {
        setupConstraints()
        setupButton()
        setupScrollView()

        cardView.configure(with: cardViewModel)
        contentView.configure(with: .init())
    }

    private func setupConstraints() {
        backgroundColor = .white

        // Scroll
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor)
        ])

        // Card
        scrollView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            cardView.heightAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 1.2)
        ])

        // Content
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: cardView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])

        // Button
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor)
        ])
    }

    private func setupButton() {
        closeButton.setImage(
            .init(named: "ic-close-button-dark")!,
            for: UIControl.State.normal
        )
    }

    private func setupScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
    }
}
