//
//  SearchTableViewController.swift
//  NircaTracker
//
//  Created by Ethan Febinger on 11/8/18.
//  Copyright © 2018 Ethan Febinger. All rights reserved.
//

import UIKit
import os.log


class SearchTableViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var searchTextField: UITextField!
    
    var athletes = [Athlete]()
    var searchResults = [Athlete]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        self.tableView.backgroundColor = UIColor.clear
        let tempImageView = UIImageView(image: UIImage(named: "nirca.png"))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView;
        
        // Load the sample data.
        loadSampleAthletes()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        print("What")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("AYY")
        
        let terms = searchTextField.text!.components(separatedBy: " ")
        
        searchResults.removeAll()
        tableView.reloadData()
        //tableView.beginUpdates()
        
        
        
        for athlete in athletes {
            
            var search = true;
                
            for term in terms {
                var collegeMatch = false
                let collegeTerms = athlete.college.components(separatedBy: " ")
                
                for var cTerm in collegeTerms{
                    if(cTerm[cTerm.count-1]==","){
                        cTerm = cTerm.substring(toIndex: cTerm.count-1)
                    }
                    if(cTerm.lowercased().elementsEqual(term.lowercased())){collegeMatch=true}
                }
                
                if( (term.lowercased().elementsEqual(athlete.firstName.lowercased())) ||
                    (term.lowercased().elementsEqual(athlete.lastName.lowercased())) ||
                    (collegeMatch)){
                    //searchResults.append(athlete)
                    //print(athlete.firstName+" "+athlete.lastName+":"+athlete.college)
                    //break;
                }else{
                    search = false;
                }
            }
            
            if(search){searchResults.append(athlete)}
            
        }
        
        tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SearchTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SearchTableViewCell.")
        }
        
        

        // Fetches the appropriate meal for the data source layout.
        let athlete = searchResults[indexPath.row]
        
        cell.nameLabel.text = athlete.firstName + " " + athlete.lastName
        cell.collegeLabel.text = athlete.college
        

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let searchDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedSearchCell = sender as? SearchTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedSearchCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedAthlete = searchResults[indexPath.row]
            searchDetailViewController.athlete = selectedAthlete
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
 

    //MARK: Private Methods
    
    private func loadSampleAthletes() {
        var myStrings = [String]()
        if let path = Bundle.main.path(forResource: "AthleteData", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                myStrings = data.components(separatedBy: .newlines)
            } catch {
                print(error)
            }
            
            while(!(myStrings.count==1)){
                
                let data = myStrings[0].components(separatedBy: "/")
                myStrings.remove(at: 0)
                let firstName = data[0]
                let lastName = data[1]
                let college = data[2]
                
                let str = myStrings[0]
                var results = [Result]()
                results.removeAll()
                //print(str[0].compare("\t")==ComparisonResult.orderedSame)
                while(!myStrings.isEmpty && myStrings[0][0]=="\t"){
                    let data = myStrings[0].components(separatedBy: "/")
                    let meetName = (data[0]).substring(fromIndex: 1)
                    let time = data[1]
                    results.append(Result(meetName: meetName, time: time))
                    myStrings.remove(at: 0)
                }
                
                athletes.append(Athlete(firstName: firstName, lastName: lastName, college: college, results: results)!)
            }
        }

    }
    
}

extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
}
}
