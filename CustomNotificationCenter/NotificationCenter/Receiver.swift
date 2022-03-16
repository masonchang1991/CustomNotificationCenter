//
//  Receiver.swift
//  CustomNotificationCenter
//
//  Created by Mason on 2022/3/16.
//

import Foundation

protocol ReciverProtocol: AnyObject {
    func setAction(_ action: (() -> ())?)
    func execute()
}

/// a Receiver have two method
class Receiver: ReciverProtocol {
    
    private(set) var action: (() -> ())? = nil
    private(set) var unregisterAction: (() -> ())? = nil
    
    func setAction(_ action: (() -> ())?) {
        self.action = action
    }
    
    func execute() {
        action?()
    }
    
    deinit {
        action = nil
        print("Receiver dealloc")
    }
}
