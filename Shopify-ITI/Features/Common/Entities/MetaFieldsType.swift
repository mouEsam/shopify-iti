//
//  MetaFieldsTypes.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation

enum MetaFieldsType: String {
    case boolean                                        // Bool:    true/false
    case color                                          // String:  #fff123
    case date                                           // String:  2022-02-02
    case dateTime = "date_time"                         // String:  2022-01-01T12:30:00
    case dimension                                      // Dict:    { "value": 25.0, "unit": "cm" }
    case json                                           // Dict:    { "ingredient": "flour", "amount": 0.3 }
    case money                                          // Dict:    { "amount": "5.99", "currency_code": "CAD" }
    case multiLineTextField = "multi_line_text_field"   // String:  Ingredients\nFlour\nWater\nMilk\nEggs
    case numberDecimal = "number_decimal"               // String:  10.4
    case numberInteger = "number_integer"               // Int:     10
    case rating                                         // Dict:    { "value": "3.5", "scale_min": "1.0", "scale_max": "5.0" }
    case richTextField = "rich_text_field"              // Dict:    { "type": "root", "children": [{ "type": "paragraph", "children": [{ "type": "text", "value": "Bold text.", "bold": true }] }] }
    case singleLineTextField = "single_line_text_field" // String:  VIP shipping method
    case url                                            // String:  https://www.shopify.com schemes: https, http, mailto, sms, tel
    case volume                                         // Dict:    { "value": 25.0, "unit": "ml" }
    case weight                                         // Dict:    { "value": 25.0, "unit": "kg" }
}
