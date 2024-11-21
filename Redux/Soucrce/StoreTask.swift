//
//  StoreTask.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/21/24.
//

import Foundation

struct StoreTask: Sendable {
    let rawValue: Task<Void, Never>?
    
    init(rawValue: Task<Void, Never>?) {
        self.rawValue = rawValue
    }
    
    func finish() async {
        await rawValue?.cancelValue
    }
    
    func cancel() {
        rawValue?.cancel()
    }
}

extension Task where Failure == Never {
    var cancelValue: Success {
        get async {
            await withTaskCancellationHandler {
                await self.value
            } onCancel: {
                self.cancel()
            }
        }
    }
}
