//
//  JobsTableController.swift
//  ghj
//
//  Created by Augusto Falcão on 11/13/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import UIKit

class JobsTableController: UITableViewController, ServerDispatcherDelegate {

    var jobs = [Job]()
    var requestParameters = ("", "")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib.init(nibName: "JobTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "JobCell")

        // let url = URL(string: "https://jobs.github.com/positions.json?description=python&location=new+york")

        let request = UserService.getJobList(requestParameters.0, requestParameters.1)
        let serverDispatcher = ServerDispatcher(environment: "https://jobs.github.com")
        serverDispatcher.delegate = self
        serverDispatcher.execute(request: request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismissController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: Job View Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let jobViewController = (segue.destination as! UINavigationController).topViewController as! JobController
        jobViewController.job = sender as? Job
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "JobViewSegue", sender: jobs[indexPath.row])
    }

    // MARK: Server Dispatcher Delegate

    func didReceiveRequestResponseData(_ data: Data?) {
        guard let receiveData = data else { return }
        do {
            let mainData = try JSONDecoder().decode([Job].self, from: receiveData)
            self.jobs = mainData
        } catch let error {
            print("Serialization error: \(error)")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
