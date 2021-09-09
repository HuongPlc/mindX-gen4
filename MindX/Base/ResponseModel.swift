//
//  ResponseModel.swift
//  MindX
//
//  Created by Hoang Van Pau on 9/9/21.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
    // MARK: - Properties

    var isSuccess: Bool
    var message: String?
    
    var error: ErrorModel {
        return ErrorModel(message)
    }

//    var rawData: Data?
    var data: T?

//    var request: RequestModel?
    init(isSuccess: Bool, message: String?) {
        self.isSuccess = isSuccess
        self.message = message
    }

    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        data = try? keyedContainer.decode(T.self, forKey: CodingKeys.data)
        isSuccess = (try? keyedContainer.decode(Bool.self, forKey: CodingKeys.isSuccess)) ?? false
    }
}

extension ResponseModel {
    private enum CodingKeys: String, CodingKey {
        case isSuccess
        case message
        case data
    }
}

class ErrorModel: Error {
    let message: String?

    init(_ message: String?) {
        self.message = message
    }
}

extension ErrorModel {
    class func generalError() -> ErrorModel {
        return ErrorModel("Error")
    }
}
