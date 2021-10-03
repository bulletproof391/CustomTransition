//
//  DailyAppsCardView.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

final class DailyAppsCardView: UIView {
    // MARK: - Properties

    private let subtitleLabel: UILabel

    private let titleLabel: UILabel

    private let descriptionLabel: UILabel

    private let backgroundImageView: UIImageView

    private var topAnchorConstraint: NSLayoutConstraint

    private var imageLeadingAnchor: NSLayoutConstraint

    private var imageTrailingAnchor: NSLayoutConstraint

    private var viewModel: DailyAppsCardViewModel?

    // MARK: - Initializer

    init() {
        self.subtitleLabel = .init()
        self.titleLabel = .init()
        self.descriptionLabel = .init()
        self.backgroundImageView = .init()
        self.topAnchorConstraint = .init()
        self.imageLeadingAnchor = .init()
        self.imageTrailingAnchor = .init()

        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions

    func configure(with viewModel: DailyAppsCardViewModel) {
        self.viewModel = viewModel

        subtitleLabel.text = viewModel.subtitle.uppercased()
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        backgroundImageView.image = viewModel.image

        switch viewModel.presentationType {
        case .card:
            updateConstraintsToCardMode()
        case .full:
            updateConstraintsToFullMode()
        }
    }

    func copy() -> UIView? {
        guard let viewModel = viewModel else {
            return nil
        }

        let view = DailyAppsCardView()
        view.frame = frame
        view.configure(with: viewModel)

        return view
    }

    func updateConstraintsToFullMode() {
        let window = UIApplication.shared.windows.first
        topAnchorConstraint.constant = 12.0 + (window?.safeAreaInsets.top ?? .zero)
        imageLeadingAnchor.constant = 0.0
        imageTrailingAnchor.constant = 0.0
    }

    func updateConstraintsToCardMode() {
        topAnchorConstraint.constant = 12.0
        imageLeadingAnchor.constant = -16.0
        imageTrailingAnchor.constant = 16.0
    }

    // MARK: - Private Functions

    private func setup() {
        setupImageView()
        setupSubtitleLabel()
        setupTitleLabel()
        setupDecriptionLabel()
    }

    private func setupImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        imageLeadingAnchor = backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        imageTrailingAnchor = backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)

        NSLayoutConstraint.activate([
            imageLeadingAnchor,
            imageTrailingAnchor,
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        backgroundImageView.contentMode = .scaleAspectFill
    }

    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        topAnchorConstraint = subtitleLabel.topAnchor.constraint(
            equalTo: self.topAnchor,
            constant: 12.0
        )

        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            topAnchorConstraint
        ])

        subtitleLabel.textColor = .white
        subtitleLabel.font = .systemFont(ofSize: 15.0, weight: .semibold)
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            titleLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 12.0)
        ])

        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 28.0, weight: .bold)
        titleLabel.textColor = .white
    }

    private func setupDecriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12.0)
        ])

        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        descriptionLabel.textColor = .white
    }
}
