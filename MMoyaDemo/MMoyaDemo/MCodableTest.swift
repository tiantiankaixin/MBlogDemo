//
//  MCodableTest.swift
//  MMoyaDemo
//
//  Created by mal on 2019/11/9.
//  Copyright © 2019 mal. All rights reserved.
//

import Foundation
import UIKit

class MResponse: NSObject, Codable {
    var msg : String = ""
    var code : Int = 100
    
    enum CodingKeys : String, CodingKey {
        case msg = "message"
    }

    override var description: String {
        return "msg:\(msg) code:\(code)"
    }
    
    class func codableTest() {
        //let dic:[String:Any] = ["name":"maliang", "age":10]
        let jsonText = """
        {
            "message": "request success",
            "code": 0
        }
        """
        if let data = jsonText.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(MResponse.self, from: data)
                print(res)
            } catch let error {
                print(error)
            }
        }
    }
}
