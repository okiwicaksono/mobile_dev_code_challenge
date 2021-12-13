//
//  ViewController.swift
//  challenge
//
//  Created by Tommy on 13/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var tableView: UITableView!
    private(set) var useCase: CallDataToViewUsecase = CallDataToViewUsecase(repository: JSONHelper())
    var data: [DataView] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        data = useCase.showDataToView()
        self.tableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = data[indexPath.row].criteria?.rawValue
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("test \(self.data[indexPath.row].detail) \(self.data[indexPath.row].timestamp)")
    }
}
