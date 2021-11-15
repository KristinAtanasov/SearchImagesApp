

import Foundation
import UIKit


struct ApiResponse: Codable{
   let total: Int
   let total_pages: Int
   let results: [Result]
}
struct Result: Codable {       
    let urls: URLS
}
struct URLS: Codable {
    let regular: String
}

