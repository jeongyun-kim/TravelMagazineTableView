//
//  Observable.swift
//  TableView_Travel
//
//  Created by 김정윤 on 7/9/24.
//

import Foundation

final class Observable<T> {
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
}
