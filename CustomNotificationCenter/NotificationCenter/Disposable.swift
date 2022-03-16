//
//  Disposable.swift
//  CustomNotificationCenter
//
//  Created by Mason on 2022/3/16.
//

import Foundation

public typealias Disposal = [Disposable]

// if the subscriber dealloc, it will execute dispose method to unsubscribe notification
public final class Disposable {
    
    private let dispose: () -> ()
    
    init(_ dispose: @escaping () -> ()) {
        self.dispose = dispose
    }
    
    deinit {
        dispose()
    }
    
    public func add(to disposal: inout Disposal) {
        disposal.append(self)
    }
}
