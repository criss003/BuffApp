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
        let numberOfAnswers = buffModel?.answers.count ?? 0
        return RowTypeModelConstants.topSections + numberOfAnswers
    }
    
    func rowInfo(at indexPath: IndexPath) -> QuestionsInfoModel {
        let index = indexPath.row < RowTypeModel.allCases.count ? indexPath.row : RowTypeModel.allCases.count - 1
        guard let rowType = RowTypeModel(rawValue: index) else {
            return QuestionsInfoModel()
        }
        return QuestionsInfoModel(value: rowType.value(buffModel: buffModel, index: indexPath.row),
                                  avatar: rowType.avatar(buffModel: buffModel),
                                  countdown: buffModel?.countdown ?? 0)
            
    }
}
