//
//  _CancelID.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/22/24.
//

import Foundation

struct _CancelID: Hashable {
    private let uuid = UUID()
    let id: AnyHashable
    
    init(id: AnyHashable) {
        self.id = id
    }
}
