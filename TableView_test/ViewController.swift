//
//  ViewController.swift
//  TableView_test
//
//  Created by user214346 on 2/3/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var people: [NSManagedObject] = []
    var names : [String?] = []
    var input : String?
    @IBOutlet weak var namelist: UITableView!
    
    @IBOutlet weak var tableButton: UIButton!
    @IBOutlet weak var text: UITextField!
    
    @IBAction func butOnClick(_ sender: Any) {
        input = text.text
        names.append(input)
        namelist.reloadData()
        text.text = ""
        if let values = input{
            save(name: values)
            getValue()
        }
    }
    
   @objc func addTapped(){
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
   
       guard let detailVC = storyboard.instantiateViewController(identifier: "detailsViewController" ) as? DetailsViewController else {
           print("ViewController not found")
           return
       }
       self.navigationController?.pushViewController(detailVC, animated: true)
       
   }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        namelist.delegate = self
        namelist.dataSource = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getValue()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return names.count
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableID", for: indexPath)
      //  cell.textLabel?.text = names[indexPath.row]
        let person = people[indexPath.row]
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        return cell
        
    }
    func save(name: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Entity",
                                   in: managedContext)!
      
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      person.setValue(name, forKeyPath: "name")
        person.setValue(0, forKeyPath: "age")
      // 4
      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func getValue(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Entity")
          
          //3
          do {
            people = try managedContext.fetch(fetchRequest)
              namelist.reloadData()
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        
    }
}

