//
//  BitcoinModel.swift
//  App Test
//
//  Created by กุลนิษฐ์ สิงห์เชื้อ on 25/8/2566 BE.
//

import Foundation

struct BitcoinPriceResponse: Codable {
    let time: Time
    let disclaimer: String
    let chartName: String
    let bpi: BPI
}



struct Time: Codable {
    let updated: String
    let updatedISO: String
    let updatedUK: String
    
    enum CodingKeys: String, CodingKey {
        case updated
        case updatedISO = "updatedISO"
        case updatedUK = "updateduk"
    }
}

struct BPI: Codable {
    let usd: Currency
    let gbp: Currency
    let eur: Currency
}

struct Currency: Codable {
    let code: String
    let symbol: String
    let rate: String
    let description: String
    let rateFloat: Double
    
    enum CodingKeys: String, CodingKey {
        case code, symbol, rate, description
        case rateFloat = "rate_float"
    }
}




