//
//  QuestionsViewModel.swift
//  BuffSDK
//
//  Created by Criss on 3/22/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation

class QuestionsViewModel {
    private var buffModel: BuffModel?
    
    func updateData(buffModel: BuffModel?) {
        self.buffModel = buffModel
    }
    
    func numberOfRows() -> Int {
        let numberOfAnswers = buffModel?.result?.answers.count ?? 0
        return RowTypeModelConstants.topSections + numberOfAnswers
    }
    
    func rowInfo(at indexPath: IndexPath) -> (value: String?, avatar: String?) {
        let index = indexPath.row < RowTypeModel.allCases.count ? indexPath.row : RowTypeModel.allCases.count - 1
        guard let rowType = RowTypeModel(rawValue: index) else {
            return (nil, nil)
        }
        return (rowType.value(buffModel: buffModel, index: indexPath.row), rowType.avatar(buffModel: buffModel))
    }
}
