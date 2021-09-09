//
//  ServiceManager.swift
//  MindX
//
//  Created by Hoang Van Pau on 9/9/21.
//

import Foundation

class ServiceManager {
    // MARK: - Properties

    static let shared: ServiceManager = ServiceManager()

    var baseURL: String = Configs.Network.baseUrl
}

// MARK: - Public Functions

extension ServiceManager {
    func sendRequest<T: Codable>(requestModel: RequestModel, completion: @escaping (Swift.Result<T, ErrorModel>) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: baseURL + requestModel.path)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = requestModel.method.rawValue
        request.allHTTPHeaderFields = requestModel.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, _, error) -> Void in
            if error != nil {
                completion(.failure(ErrorModel(error?.localizedDescription)))
            } else {
                let decoder = JSONDecoder()
                guard let data = data, let parsedResponse = try? decoder.decode(T.self, from: data) else {
                    return
                }
                completion(.success(parsedResponse))
            }
        })

        dataTask.resume()
    }
}
