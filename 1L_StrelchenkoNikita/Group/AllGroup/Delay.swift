//
//  Delay.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 01.10.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import Foundation

import Foundation

class Delay {
    private var timer: Timer?
    private let delayTime = 0.85
    
    // @escaping - сбегающее замыкание
    func delayTime(run: @escaping (() -> Void)) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delayTime, repeats: false) { _ in run() }
    }
}
