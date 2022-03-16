//
//  CNotificationCenter.swift
//  CustomNotificationCenter
//
//  Created by Mason on 2022/3/16.
//

import Foundation

protocol CNotificationCenter {
    func subscribe(by key: NotificationKey, action: (() -> ())?) -> (ReciverProtocol, Disposable)
    func notify(by key: NotificationKey)
    func unsubscribe(reciever: ReciverProtocol, subscribeKey: NotificationKey)
}

class CustomNotificationCenter: CNotificationCenter {
    
    static let shared = CustomNotificationCenter()
    
    private var receivers: [NotificationKey: [Receiver]] = [:]
    
    func subscribe(by key: NotificationKey, action: (() -> ())?) -> (ReciverProtocol, Disposable) {
        let receiver = Receiver()
        receiver.setAction(action)
        
        if var receiverGroup = receivers[key] {
            receiverGroup.append(receiver)
        } else {
            receivers[key] = [receiver]
        }
        
        let disposable = Disposable { [weak self, unowned receiver] in
            guard let self = self else { return }
            self.unsubscribe(reciever: receiver, subscribeKey: key)
        }
        
        return (receiver, disposable)
    }
    
    func unsubscribe(reciever: ReciverProtocol, subscribeKey: NotificationKey) {
        if let receiverGroup = receivers[subscribeKey] {
            let newReceiverGroup = receiverGroup.filter { $0 !== reciever }
            receivers[subscribeKey] = newReceiverGroup
        }
    }
    
    func notify(by key: NotificationKey) {
        if let receiverGroup = receivers[key] {
            receiverGroup.forEach { $0.execute() }
        }
    }
}

