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
    static private let clientId = "???"
    static private let clientSecret = "???"
    
    case image(UIImage)    
}

extension ImageAPI: TargetType{
    public var baseURL: URL {
        return URL(string: "http://128.179.140.49:8080")!
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
        let dict = [String: Any]()
        
        switch self{
        case .image(let image):
            let imageData = image.pngData()
            debugPrint(imageData)
            //let imageAsString = String(data: imageData!, encoding: String.Encoding.utf8) as String!
            let strBase64 = imageData!.base64EncodedString(options: .lineLength64Characters)
            //debugPrint(imageAsString!)
            return .requestParameters(parameters: ["image" : strBase64], encoding: URLEncoding.default)

        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json", "Accept": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
