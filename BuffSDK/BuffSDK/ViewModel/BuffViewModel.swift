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
    var idRequest: Int = BuffViewModelConstants.idMinValue
    private var timer: Timer?
    
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
}
