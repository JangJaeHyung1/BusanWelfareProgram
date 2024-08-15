//
//  NetworkViewModel.swift
//  BusanWelfareProgram
//
//  Created by jh on 8/15/24.
//

import Foundation

class NetworkViewModel {
    private var apiService: APIService
    var data: DataModel?

    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func loadData(numOfRows: Int, pageNo: Int) async throws -> [Item] {
        guard let decodedKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            throw NetworkError.invalidAPIKey
        }
        
        let queryItems = [
            URLQueryItem(name: "ServiceKey", value: decodedKey),
            URLQueryItem(name: "numOfRows", value: "\(numOfRows)"),
            URLQueryItem(name: "pageNo", value: "\(pageNo)"),
            URLQueryItem(name: "resultType", value: "json")
        ]
        
        let endpoint = Endpoint(path: "6260000/SocialWelfareCenterProgramsService/getProgramInfoList", method: .get, queryItems: queryItems)
        
        do {
            let data: DataModel = try await apiService.fetchData(from: endpoint)
            self.data = data
            return data.response.body.items.item
        } catch {
            throw NetworkError.requestFailed(description: error.localizedDescription)
        }
    }
}
