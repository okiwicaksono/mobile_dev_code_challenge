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
        self.tableView.register(UINib(nibName: String(describing: CellTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CellTableViewCell.self))
        data = useCase.showDataToView()
        self.tableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellTableViewCell.self),for: indexPath) as! CellTableViewCell
        cell.dateLable.text = self.data[indexPath.row].timestamp.description
        cell.fromLabel.text = "dari \(self.data[indexPath.row].from!)"
        cell.title.text = self.data[indexPath.row].criteria?.rawValue
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.loadViewIfNeeded()
        if self.data[indexPath.row].detail.isEmpty {
            vc.detailLabel.text = "\(self.data[indexPath.row])"
        }else{
            vc.detailLabel.text = self.data[indexPath.row].detail.description
        }
        self.present(vc, animated: true, completion: nil)
    }
}
