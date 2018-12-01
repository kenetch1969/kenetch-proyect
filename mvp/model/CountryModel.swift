//
//  CountryModel.swift
//  mvp
//
//  Created by Juan Gerardo Cruz on 11/27/18.
//  Copyright © 2018 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

//{
//    "name": "Mexico",
//    "topLevelDomain": [
//    ".mx"
//    ],
//    "alpha2Code": "MX",
//    "alpha3Code": "MEX",
//    "callingCodes": [
//    "52"
//    ],
//    "capital": "Mexico City",
//    "altSpellings": [
//    "MX",
//    "Mexicanos",
//    "United Mexican States",
//    "Estados Unidos Mexicanos"
//    ],
//    "region": "Americas",
//    "subregion": "Central America",
//    "population": 122273473,
//    "latlng": [
//    23,
//    -102
//    ],
//    "demonym": "Mexican",
//    "area": 1964375,
//    "gini": 47,
//    "timezones": [
//    "UTC-08:00",
//    "UTC-07:00",
//    "UTC-06:00"
//    ],
//    "borders": [
//    "BLZ",
//    "GTM",
//    "USA"
//    ],
//    "nativeName": "México",
//    "numericCode": "484",
//    "currencies": [
//    {
//    "code": "MXN",
//    "name": "Mexican peso",
//    "symbol": "$"
//    }
//    ],
//    "languages": [
//    {
//    "iso639_1": "es",
//    "iso639_2": "spa",
//    "name": "Spanish",
//    "nativeName": "Español"
//    }
//    ],
//    "translations": {
//        "de": "Mexiko",
//        "es": "México",
//        "fr": "Mexique",
//        "ja": "メキシコ",
//        "it": "Messico",
//        "br": "México",
//        "pt": "México",
//        "nl": "Mexico",
//        "hr": "Meksiko",
//        "fa": "مکزیک"
//    },
//    "flag": "https://restcountries.eu/data/mex.svg",
//    "regionalBlocs": [
//    {
//    "acronym": "PA",
//    "name": "Pacific Alliance",
//    "otherAcronyms": [],
//    "otherNames": [
//    "Alianza del Pacífico"
//    ]
//    },
//    {
//    "acronym": "NAFTA",
//    "name": "North American Free Trade Agreement",
//    "otherAcronyms": [],
//    "otherNames": [
//    "Tratado de Libre Comercio de América del Norte",
//    "Accord de Libre-échange Nord-Américain"
//    ]
//    }
//    ],
//    "cioc": "MEX"
//}

struct Country: Codable{
    let name: String
    let topLevelDomain:[String]
    let alpha2Code:String
    let alpha3Code:String
    let callingCodes:[String]
    let capital:String
    let altSpellings:[String]?
    let region:String?
    let subregion:String?
    let population:Int32?
    let latlng:[Float]?
    let demonym:String?
    let area:Float?
    let gini:Float?
    let timezones:[String]?
    let borders:[String]?
    let nativeName:String?
    let numericCode:String?
    let currencies:[Currencies]
    let languages:[Languages]
    let translations:Translations?
    let flag:String?
    let regionalBlocs:[RegionalBlocs]?
    let cioc:String?
    
}

//    "currencies": [
//    {
//    "code": "MXN",
//    "name": "Mexican peso",
//    "symbol": "$"
//    }
//    ],
struct Currencies:Codable {
    let code:String?
    let name:String?
    let symbol:String?
}

//    "languages": [
//    {
//    "iso639_1": "es",
//    "iso639_2": "spa",
//    "name": "Spanish",
//    "nativeName": "Español"
//    }

struct Languages:Codable {
    let iso6391: String?
    let iso6392: String?
    let name: String?
    let nativeName:String?
    
    private enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name
        case nativeName
    }
    
}
//    "translations": {
//        "de": "Mexiko",
//        "es": "México",
//        "fr": "Mexique",
//        "ja": "メキシコ",
//        "it": "Messico",
//        "br": "México",
//        "pt": "México",
//        "nl": "Mexico",
//        "hr": "Meksiko",
//        "fa": "مکزیک"
//    },

struct Translations:Codable {
    let de:String?
    let es:String?
    let fr:String?
    let ja:String?
    let it:String?
    let br:String?
    let pt:String?
    let nl:String?
    let hr:String?
    let fa:String?
}
//    "regionalBlocs": [
//    {
//    "acronym": "PA",
//    "name": "Pacific Alliance",
//    "otherAcronyms": [],
//    "otherNames": [
//    "Alianza del Pacífico"
//    ]
//    },
//    {
//    "acronym": "NAFTA",
//    "name": "North American Free Trade Agreement",
//    "otherAcronyms": [],
//    "otherNames": [
//    "Tratado de Libre Comercio de América del Norte",
//    "Accord de Libre-échange Nord-Américain"
//    ]
//    }
//    ],

struct RegionalBlocs:Codable{
    let acronym:String?
    let name:String?
    let otherAcronyms:[String]?
    let otherNames:[String]?
}

