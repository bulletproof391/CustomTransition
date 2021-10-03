//
//  DailyAppsCardViewModel.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

struct DailyAppsCardViewModel {
    // MARK: - Properties

    let image: UIImage?

    let subtitle: String

    let title: String

    let description: String

    var presentationType: DailyAppsCardView.Presentation

    // MARK: - Initializer

    init(
        image: UIImage?,
        subtitle: String,
        title: String,
        description: String,
        presentationType: DailyAppsCardView.Presentation
    ) {
        self.image = image
        self.subtitle = subtitle
        self.title = title
        self.description = description
        self.presentationType = presentationType
    }
}
