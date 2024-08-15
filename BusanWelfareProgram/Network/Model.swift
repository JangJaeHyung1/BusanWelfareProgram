//
//  Model.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/17.
//

import Foundation

// MARK: - Welcome
struct DataModel: Codable {
    let response: Response
}
struct Response: Codable {
//    let header: Header
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    let items: Items
    let numOfRows, pageNo, totalCount: String
}

// MARK: - Items
struct Items: Codable {
    let item: [Item]
}

// MARK: - Item
struct Item: Codable {
    let gugun, centerNm, addrRoad, tel: String
    let programNm, applyURL, programDetail, startDate: String
    let finishDate, cost, target, lat: String
    let lng, dataDay: String

    enum CodingKeys: String, CodingKey {
        case gugun
        case centerNm = "center_nm"
        case addrRoad = "addr_road"
        case tel
        case programNm = "program_nm"
        case applyURL = "apply_url"
        case programDetail = "program_detail"
        case startDate = "start_date"
        case finishDate = "finish_date"
        case cost, target, lat, lng
        case dataDay = "data_day"
    }
}
