//
//  RequestModel.swift
//  MindX
//
//  Created by Hoang Van Pau on 9/9/21.
//

import Foundation

enum RequestHTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
}

class RequestModel: NSObject {
    // MARK: - Properties

    var path: String {
        return ""
    }

    var parameters: [String: Any?] {
        return [:]
    }

    var headers: [String: String] {
        return [
            "x-rapidapi-host": Configs.Constant.apiHost,
            "x-rapidapi-key": Configs.Constant.apiKey,
        ]
    }

    var method: RequestHTTPMethod {
        return body.isEmpty ? RequestHTTPMethod.get : RequestHTTPMethod.post
    }

    var body: [String: Any?] {
        return [:]
    }
}

extension RequestModel {
    func urlRequest() -> URLRequest {
        var endpoint: String = ServiceManager.shared.baseURL.appending(path)

        for parameter in parameters {
            if let value = parameter.value as? String {
                endpoint.append("?\(parameter.key)=\(value)")
            }
        }

        var request: URLRequest = URLRequest(url: URL(string: endpoint)!)

        request.httpMethod = method.rawValue

        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        if method == RequestHTTPMethod.post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let error {
                print("Request body parse error: \(error.localizedDescription)")
            }
        }

        return request
    }
}
