//
//  Model.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/17.
//

import Foundation

// MARK: - Data
struct WelfareData: Codable {
    let getProgramInfo: GetProgramInfo
}

// MARK: - GetProgramInfo
struct GetProgramInfo: Codable {
    let header: Header
    let item: [Item]
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Header
struct Header: Codable {
    let code, message: String
}

// MARK: - Item
struct Item: Codable {
    let cost, target, lat, lng: String
    let dataDay: String
    let gugun: String
    let centerNm: String
    let addrRoad: String
    let tel: String
    let programNm, programDetail, startDate, finishDate: String

    enum CodingKeys: String, CodingKey {
        case cost, target, lat, lng
        case dataDay = "data_day"
        case gugun
        case centerNm = "center_nm"
        case addrRoad = "addr_road"
        case tel
        case programNm = "program_nm"
        case programDetail = "program_detail"
        case startDate = "start_date"
        case finishDate = "finish_date"
    }
}
