//
//  ViewController.swift
//  Source
//
//  Created by JAN FREDRICK on 23/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var messageList: [ItemList] = []
    var groupedList: [ItemList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(MessageTableViewCell.nib(), forCellReuseIdentifier: MessageTableViewCell.identifier)
        mainTableView.register(MessageBTableViewCell.nib(), forCellReuseIdentifier: MessageBTableViewCell.identifier)
        
        mainTableView.register(ImageCollectionTableViewCell.nib(), forCellReuseIdentifier: ImageCollectionTableViewCell.identifier)
        mainTableView.register(ImageCollectionBTableViewCell.nib(), forCellReuseIdentifier: ImageCollectionBTableViewCell.identifier)
        
        mainTableView.separatorStyle = .none
        mainTableView.showsVerticalScrollIndicator = false
        
        if let localData = readLocalFile(forName: "message_dataset") {
            self.parse(jsonData: localData)
            
            groupedList = grouped(list: messageList)
            
            print("\(messageList.count) VS \(groupedList.count)")
        }
        
    }
    
    func grouped(list: [ItemList]) -> [ItemList] {
        
        var newList: [ItemList] = []
        
        var newI = 0
        
        for _ in 0..<list.count {
            
            if newI >= list.count {
                break
            }
            
            let item = list[newI]
            
            if item.attachment == nil || item.attachment!.contains("document") {
                newList.append(item)
                
                newI += 1
            }else{
                var num = newI
                var counter = 0
                var attachments = list[num].attachment ?? "unknown"
                
                while num+1 != list.count {
                    
                    if list[num+1].attachment == list[num].attachment && list[num+1].from == list[num].from {
                        counter += 1
                        attachments += "|\(list[num+1].attachment ?? "unknown")"
                        
                        num += 1
                    }else{
                        break
                    }
                    
                }
                
                counter += 1
                
                if counter == 1 {
                    newList.append(item)
                }else{
                    newList.append(ItemList(id: item.id, body: item.body, attachment: attachments, timestamp: item.timestamp, from: item.from, to: item.to))
                }
                
                newI += counter
            }
            
        }
        
        return newList
        
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(DataModel.self, from: jsonData)
            
            messageList = decodedData.data
            print("Result: ", messageList)
            
        } catch {
            print("decode error")
        }
    }

    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                print(bundlePath)
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedList.count//messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var prevItem: ItemList?
        let item = groupedList[indexPath.row]//messageList[indexPath.row]
        
        if indexPath.row != 0 {
            prevItem = groupedList[indexPath.row - 1]//messageList[indexPath.row - 1]
        }
        
        if (item.attachment == nil || item.attachment!.contains("document") || item.attachment!.contains("contact")) && item.from == "A" {
            //this is message
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.identifier, for: indexPath) as! MessageTableViewCell
            
            if let prevObject = prevItem, prevObject.from == item.from {
                cell.profileImgae.isHidden = true
            }else{
                cell.profileImgae.isHidden = false
            }
            
            cell.model = item
            
            return cell
        }else if (item.attachment == nil || item.attachment!.contains("document") || item.attachment!.contains("contact")) && item.from == "B" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageBTableViewCell.identifier, for: indexPath) as! MessageBTableViewCell
            
            if let prevObject = prevItem, prevObject.from == item.from {
                cell.profileImage.isHidden = true
            }else{
                cell.profileImage.isHidden = false
            }
            
            cell.model = item
            
            return cell
        }else if item.from == "A" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCollectionTableViewCell.identifier, for: indexPath) as! ImageCollectionTableViewCell
            
            if let prevObject = prevItem, prevObject.from == item.from {
                cell.profileImage.isHidden = true
            }else{
                cell.profileImage.isHidden = false
            }
            
            cell.model = item
            
            return cell
        }else if item.from == "B" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCollectionBTableViewCell.identifier, for: indexPath) as! ImageCollectionBTableViewCell
            
            if let prevObject = prevItem, prevObject.from == item.from {
                cell.profileImage.isHidden = true
            }else{
                cell.profileImage.isHidden = false
            }
            
            cell.model = item
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = groupedList[indexPath.row]
        
        if let attachments = item.attachment, attachments.contains("image") {
            if attachments.split(separator: "|").count != 2 {
                return 180
            }else{
                return 100
            }
        }
        
        return UITableView.automaticDimension
    }
    
}
