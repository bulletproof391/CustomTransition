//
//  AppDetailContentView.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

final class AppDetailContentView: UIView {
    // MARK: - Properties

    private let descriptionLabel: UILabel

    // MARK: - Initializer

    init() {
        self.descriptionLabel = .init()

        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Functions

    func configure(with viewModel: AppDetailContentViewModel) {
        descriptionLabel.text = viewModel.text
    }

    // MARK: - Private Functions

    private func setup() {
        backgroundColor = .white

        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12.0)
        ])

        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
    }
}
