import Foundation

struct BestResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [BestResultData]?
}

// MARK: - Datum
struct BestResultData: Codable {
    let bookID: Int
    let bookImg: String
    let bookName, author: String

    enum CodingKeys: String, CodingKey {
        case bookID = "bookId"
        case bookImg, bookName, author
    }
}
