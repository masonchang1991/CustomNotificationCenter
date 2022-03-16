//
//  ViewController.swift
//  CustomNotificationCenter
//
//  Created by Mason on 2022/3/16.
//

import UIKit

class ViewController: UIViewController {
    
    var object: AObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.object = AObject()
        self.object?.subscribe()
        // if object dealloc, the action closure will be dealloced too
//        self.object = nil
//        self.object?.unsubscribe()
        CustomNotificationCenter.shared.notify(by: .test)
    }
}

class AObject {

    // for auto dealloc receiver
    var disposal: [Disposable] = []
    private weak var receiver: ReciverProtocol?
    
    func subscribe() {
        let (receiver, disposable) = CustomNotificationCenter.shared.subscribe(by: .test) {
            print("do something when be notified")
        }
        self.receiver = receiver
        disposable.add(to: &disposal)
    }
    
    func unsubscribe() {
        CustomNotificationCenter.shared.unsubscribe(reciever: receiver!, subscribeKey: .test)
    }
    
    deinit {
        print("AObject dealloc")
    }
}

