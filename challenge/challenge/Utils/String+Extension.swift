//
//  challenge
//
//  Created by Tommy on 13/12/21.
//

import Foundation

extension String {
    func formatToDate() -> (date: Date, dateString: String) {
        let epocTime = TimeInterval(Double(self) ?? 0)
        let myDate = Date(timeIntervalSince1970: epocTime)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        let date: Date = dateFormatterGet.date(from: myDate.description) ?? Date()

        return (date: myDate, dateString: dateFormatterPrint.string(from: date))
    }
}

