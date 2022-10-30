//
//  ApiLogger.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import Foundation
import Alamofire

final class ApiLogger: EventMonitor {
    let queue = DispatchQueue(label: "HongikTimer_ApiLogger")
    
    // Event called when any type of Request is resumed.
    func requestDidResume(_ request: Request) {
        print("Resuming: \(request)")
    }
    
    // Event called whenever a DataRequest has parsed a response.
    func request<Value>(
        _ request: DataStreamRequest,
        didParseStream result: Result<Value, AFError>
    ) {
        debugPrint("Finished")
    }
}
