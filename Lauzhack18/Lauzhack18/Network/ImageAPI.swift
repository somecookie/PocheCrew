//
//  Authentication.swift
//  Pedibook
//
//  Created by Lionel Pellier on 20/10/2018.
//  Copyright © 2018 Lionel Pellier. All rights reserved.
//

import Foundation
import Moya
import UIKit

public enum ImageAPI{    
    case image(UIImage)    
}

extension ImageAPI: TargetType{
    public var baseURL: URL {
        print(IP_SERVER)
        return URL(string: IP_SERVER)!
    }
    
    public var path: String {
        switch self {
        case .image: return "/helloFromIos"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .image: return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self{
        case .image(let image):
            let imageData = image.pngData()
            let strBase64 = imageData!.base64EncodedString(options: .init(rawValue: 0))

            return .requestParameters(parameters: ["image" : strBase64], encoding: JSONEncoding.default)

        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json", "Accept": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
