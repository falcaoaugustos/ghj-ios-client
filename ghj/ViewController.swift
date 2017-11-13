//
//  ViewController.swift
//  ghj
//
//  Created by Augusto Falcão on 11/8/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, ServerDispatcherDelegate {

    var jobs = [Job]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib.init(nibName: "JobTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "JobCell")
        /*
        let url = URL(string: "https://jobs.github.com/positions.json?description=python&location=new+york")
         */

        let request = UserService.getJobList("python", "san francisco")
        let serverDispatcher = ServerDispatcher(environment: "https://jobs.github.com")
        serverDispatcher.delegate = self
        serverDispatcher.execute(request: request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobTableViewCell
        cell.job = jobs[indexPath.row]
        cell.loadData()

        return cell
    }

    // MARK: Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("BOM")
    }

    // MARK: Server Dispatcher Delegate

    func didReceiveRequestResponseData(_ data: Data?) {
        guard let receiveData = data else { return }
        do {
            let mainData = try JSONSerialization.jsonObject(with: receiveData, options: []) as! [[String: Any]]
            mainData.forEach({
                let job = Job(
                    id: $0["id"] as? String ?? "",
                    title: $0["title"] as? String ?? "",
                    location: $0["location"] as? String ?? "",
                    type: $0["type"] as? String ?? "",
                    company: $0["company"] as? String ?? "",
                    companyUrl: $0["company_url"] as? String ?? "",
                    companyLogo: $0["company_logo"] as? String ?? "",
                    url: $0["url"] as? String ?? ""
                )
                self.jobs.append(job)
            })
        } catch {
            print("Serialization error:")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
