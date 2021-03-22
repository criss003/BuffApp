//
//  BuffViewModel.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation

struct BuffViewModelConstants {
    static let timerInterval = 3.0
    static let idMinValue = 1
    static let idMaxValue = 5
}

protocol BuffViewModelDelegate: class {
    func modelUpdateDidSucced()
    func modelUpdateDidFail(error: BuffError)
}

class BuffViewModel {
        
    // MARK: Vars
    
    weak var delegate: BuffViewModelDelegate?
    private var idRequest: Int = BuffViewModelConstants.idMinValue
    private var timer: Timer?
    private var buffModel: BuffModel?
    
    // MARK: Methods
    
    func startMonitoringQuestions() {
        timer = Timer.scheduledTimer(timeInterval: BuffViewModelConstants.timerInterval, target: self, selector: #selector(requestBuffs), userInfo: nil, repeats: true)
    }
    
    func stopMonitoringQuestions() {
        timer?.invalidate()
        timer = nil
    }
        
    @objc
    func requestBuffs() {
        fetchBuffs()
        updateId()
    }
    
    func fetchBuffs() {
        BuffService().fetchBuffs(id: idRequest) { buffError in
            self.delegate?.modelUpdateDidFail(error: buffError)
        } successHandler: { buffData in
            print(buffData)
            self.buffModel = buffData
            self.delegate?.modelUpdateDidSucced()
        }
    }
    
    func updateId() {
        if idRequest >= BuffViewModelConstants.idMaxValue {
            idRequest = BuffViewModelConstants.idMinValue
        } else {
            idRequest += 1
        }
    }
    
    // MARK: Buff Details
    
    func numberOfRows() -> Int {
        let numberOfAnswers = buffModel?.result?.answers.count ?? 0
        return RowTypeModelConstants.topSections + numberOfAnswers
    }
    
    func rowInfo(at indexPath: IndexPath) -> (value: String?, avatar: String?) {
        guard let rowType = RowTypeModel(rawValue: indexPath.row) else {
            return (nil, nil)
        }
        return (rowType.value(buffModel: buffModel, index: indexPath.row), rowType.avatar(buffModel: buffModel))
    }
}
