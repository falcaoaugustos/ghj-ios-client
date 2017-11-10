//
//  ViewController.swift
//  ghj
//
//  Created by Augusto Falcão on 11/8/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var jobs = [Job]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib.init(nibName: "JobTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "JobCell")

        let url = URL(string: "https://jobs.github.com/positions.json?description=python&location=new+york")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            self.vaiDarATreta(receivedData: data)
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func vaiDarATreta(receivedData: Data?) {
        guard let data = receivedData else { return }
        do {
            let mainData = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
            mainData.forEach({
                print("dolar zero: \($0)")
                let job = Job(
                    id: $0["id"] as! String,
                    title: $0["title"] as! String,
                    location: $0["location"] as! String,
                    type: $0["type"] as! String,
                    company: $0["company"] as! String,
                    companyUrl: $0["company_url"] as! String,
                    // companyLogo: $0["company_logo"] as! String,
                    url: $0["url"] as! String
                )
                print("glorioso job: \(job)")
                self.jobs.append(job)
            })
        } catch {
            print("Serialization error:")
        }
        tableView.reloadData()
    }

    // MARK: Data Source

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

    // MARK: Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("BOM")
    }

}

