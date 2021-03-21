//
//  QuestionsView.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import UIKit

private struct QuestionsViewConstants {
    static let title = " "
}

protocol QuestionsViewDelegate: class {
    func didRequestAction(questionsView: QuestionsView)
}

@IBDesignable
class QuestionsView: UIViewNibLoadable {
    
}
