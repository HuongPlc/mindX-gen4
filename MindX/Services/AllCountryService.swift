//
//  AllCountryService.swift
//  MindX
//
//  Created by Hoang Van Pau on 9/9/21.
//

import Foundation

class AllCountryService {
    static func getAll(complete: @escaping ((Result<BaseModel<Country>, ErrorModel>) -> Void)) {
        ServiceManager.shared.sendRequest(requestModel: AllCountryModel(), completion: complete)
    }
}

class WorldPopulationService {
    static func getInfo(complete: @escaping ((Result<BaseModel<WorldPopulation>, ErrorModel>) -> Void)) {
        ServiceManager.shared.sendRequest(requestModel: WorldPopulationModel(), completion: complete)
    }
}


class BaseModel<T: Codable>: Codable {
    let body: T
    
    init(body: T) {
        self.body = body
    }
}

struct Country: Codable {
    var countries: [String] = []
}

struct WorldPopulation: Codable {
    let world_population: Double
    let total_countries: Double
}
