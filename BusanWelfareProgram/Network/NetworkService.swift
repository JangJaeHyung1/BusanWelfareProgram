//
//  NetworkService.swift
//  BusanWelfareProgram
//
//  Created by jh on 8/15/24.
//

import Foundation


class NetworkService: APIService {
    func fetchData<T>(from endpoint: Endpoint) async throws -> T where T : Decodable {
        try await APIClient.shared.request(endpoint)
    }
}
