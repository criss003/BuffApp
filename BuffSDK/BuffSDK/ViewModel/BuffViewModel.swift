//
//  BuffViewModel.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation

struct BuffViewModelConstants {
    static let timerInterval = 30.0
    static let idMinValue = 1
    static let idMaxValue = 5
}

protocol BuffViewModelDelegate: class {
    func modelUpdateDidSucced(buffModel: BuffModel?)
    func modelUpdateDidFail(error: BuffError)
}

class BuffViewModel {
    
    // MARK: Vars
    
    weak var delegate: BuffViewModelDelegate?
    
    private var buffModel: BuffModel?
    private var idRequest = BuffViewModelConstants.idMinValue
    private var timer: Timer?
    
    var idBuff: Int {
        return idRequest
    }
    
    var buff: BuffModel? {
        return buffModel
    }
    
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
            self.configure(buffDecodable: buffData)
            self.delegate?.modelUpdateDidSucced(buffModel: self.buffModel)
        }
    }
    
    func configure(buffDecodable: BuffDecodable) {
        self.buffModel = BuffModel(buffDecodable: buffDecodable)
    }
    
    func updateId() {
        if idRequest >= BuffViewModelConstants.idMaxValue {
            idRequest = BuffViewModelConstants.idMinValue
        } else {
            idRequest += 1
        }
    }
}
