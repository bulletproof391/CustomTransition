//
//  DailyAppsCardCell.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

final class DailyAppsCardCell: UITableViewCell {
    // MARK: - Properties

    static var identifier: String {
        String(describing: DailyAppsCardCell.self)
    }

    var cardView: DailyAppsCardView

    private let shadowView: UIView

    // MARK: - Initializer

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        self.shadowView = .init()
        self.cardView = .init()

        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        selectionStyle = .none
        setupShadowView()
        setupCardView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Functions

    func configure(with viewModel: DailyAppsCardViewModel) {
        cardView.configure(with: viewModel)
    }

    // MARK: - Private Functions

    private func setupShadowView() {
        setupShadowViewAppearance()
        setupShadowViewConstraints()
    }

    private func setupCardView() {
        shadowView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])

        cardView.layer.cornerRadius = shadowView.layer.cornerRadius
        cardView.clipsToBounds = true
    }

    private func setupShadowViewAppearance() {
        shadowView.layer.cornerRadius = 20.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowRadius = 8.0
        shadowView.layer.shadowOffset = .init(
            width: -1.0,
            height: -2.0
        )
    }

    private func setupShadowViewConstraints() {
        contentView.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            shadowView.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 32.0),
            shadowView.heightAnchor.constraint(equalTo: shadowView.widthAnchor, multiplier: 1.2)
        ])
    }
}
