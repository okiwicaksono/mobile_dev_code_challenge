//
//  callDataToView.swift
//  challenge
//
//  Created by Tommy on 13/12/21.
//

import Foundation

struct CallDataToViewUsecase {
    private var repository: JSONHelper
    private var response: DataResponse
    
    init(repository: JSONHelper) {
        self.repository = repository
        self.response = self.repository.loadJson(filename: "message_dataset")
    }
    
    func showDataToView() -> [DataView] {
        var data: [DataView] = []

        for item in self.response.data {
            if item.attachment == nil {
               data.append(DataView(criteria: Criteria.text, title: item.body, detail: [], from: item.from, to: item.to, timestamp: item.timestamp.formatToDate().date))
            }
            data.append(contentsOf: appendDataAttachment(response: self.response, attachment: "image"))
            data.append(contentsOf: appendDataAttachment(response: self.response, attachment: "contact"))

        }
        return data.sorted { $0.timestamp < $1.timestamp }
    }
    
    func appendDataAttachment(response: DataResponse, attachment: String)-> [DataView]{
        var result: [DataView] = []
        var detail: [DataDetailView] = []
        var detailTemp: [DataDetailView] = []
        var response = self.response.data
        response.append(DataSetDetail(id: -1, body: "", attachment: attachment, timestamp: "", from: "", to: ""))
        for item in response {
            if item.attachment == attachment {
                if  detail.contains(where: { detail in
                    detail.timestamp == item.timestamp.formatToDate().dateString
                }){
                    detail.append(DataDetailView(title: "", timestamp: item.timestamp.formatToDate().dateString))
                    detailTemp.append(DataDetailView(title: "", timestamp: item.timestamp.formatToDate().dateString))
                }else{
                    if detail.last?.timestamp != item.timestamp.formatToDate().dateString {
                        if !detailTemp.isEmpty {
                            result.append(DataView(criteria: Criteria.image, title: "", detail: detailTemp, from: item.from, to: item.to, timestamp: item.timestamp.formatToDate().date))
                        }
                    }
                    detailTemp = []
                    detailTemp.append(DataDetailView(title: "", timestamp: item.timestamp.formatToDate().dateString))
                    detail.append(DataDetailView(title: "", timestamp: item.timestamp.formatToDate().dateString))
                }
            }
        }
        return result
    }
        
  
}
