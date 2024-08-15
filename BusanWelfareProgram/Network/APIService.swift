//
//  APIService.swift
//  BusanWelfareProgram
//
//  Created by jh on 8/15/24.
//

import Foundation


protocol APIService {
    func fetchData<T: Decodable>(from endpoint: Endpoint) async throws -> T
}
