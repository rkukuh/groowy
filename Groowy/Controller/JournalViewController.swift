//
//  JournalViewController.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/14/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData
extension JournalViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        //imageTake.image = selectedImage
    }
}

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate {
    var scene: GameScene!
    var timer: Timer!
    var imagePicker: UIImagePickerController!
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    private var fetchedResults: NSFetchedResultsController<Challenge>!
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let formatter = DateFormatter()
    
    @IBOutlet weak var spriteKit: SKView!
    @IBOutlet weak var journalTableView: UITableView!
    
    
    @IBAction func closeJournal(_ sender: UIButton) {
        /*guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
        */
        
        // prepare json data
        let json: [String: Any] = ["username": "jaya","email": "jaya_pranata@hotmail.co.id","link":"saya suka sama siapa?",
                                   "dict": ["1":"First", "2":"Second"]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "http://glorious-institution.com/restGroowie/rest_controller.php/email")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
        
        //dismiss(animated: false, completion: nil)
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResults.sections,
            let objs = sections[section].objects else {
                return 0
        }        
        return objs.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func setupGameScene() {
        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
        //scene.groowyCharacter.setImagePosition(position: CGPoint(x: spriteKit.frame.midX, y: spriteKit.frame.midY + spriteKit.frame.width / 2))
        scene.scaleMode = .resizeFill
        scene.sceneDidLoad()
        spriteKit.ignoresSiblingOrder = true
        spriteKit.presentScene(scene)
    }
    
    func stayAwake() {
        timer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 1...3), repeats: false, block: { (timer) in
            GroowieSound.changeSoundEffect(sound: .blink)
            self.scene.groowyCharacter.setImagePosition(position: CGPoint(x: self.spriteKit.frame.midX, y: self.spriteKit.frame.midY + self.spriteKit.frame.width / 2))
            self.scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
            self.stayAwake()
        })
    }
    
    func awake(){
        self.scene.groowyCharacter.setImagePosition(position: CGPoint(x: self.spriteKit.frame.midX, y: self.spriteKit.frame.midY + self.spriteKit.frame.width / 2))
        self.scene.groowyCharacter.changeGroowyAnimateState(nextState: .awake)
        self.stayAwake()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellJournal", for: indexPath) as! JournalTableViewCell
        let challange = fetchedResults.object(at: indexPath)
        cell.numberLabel.text = "\(indexPath.row + 1)."
        cell.titleLabel.text = challange.title
        if indexPath.row % 2 == 0 {
            //cell.colorContainer.backgroundColor = COLOR_CELL_BROWN
        }else{
            //cell.colorContainer.backgroundColor = COLOR_CELL_BROWN_LIGHT
        }
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if challange.finished_at != nil {
            let myString = String(format: "%@", challange.finished_at!)
            cell.dateLabel.text = myString
        }else{
            cell.dateLabel.text = ""
        }
        return cell
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
        
        journalTableView.delegate = self
        journalTableView.dataSource = self
        journalTableView.reloadData()
        setupGameScene()
        awake()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    private func refreshData() {
        let request = Challenge.fetchRequest() as NSFetchRequest<Challenge>
        //request.predicate = NSPredicate(format: "finished_at != nil")
        
        let sortDate = NSSortDescriptor(key: #keyPath(Challenge.finished_at), ascending: true,
                                          selector: #selector(NSString.caseInsensitiveCompare(_:)))
 
        /*let friendEyeColor = NSSortDescriptor(key: #keyPath(Friend.eyeColor), ascending: true)*/
        //request.sortDescriptors = [friendEyeColor, friendName]
        
        request.sortDescriptors = [sortDate]
        
        do {
            fetchedResults = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedResults.performFetch()
            
            
            if let sections = fetchedResults.sections{
                if let objs = sections[0].objects {
                    print("\(objs.count)")
                }
            }
         
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueDetailJournal"){
            if let detail = segue.destination as? DetailJournalViewController{
                if let index = journalTableView.indexPathForSelectedRow{
                    //let challange = fetchedResults.object(at: index)
                    detail.challange = fetchedResults.object(at: index)
                }
                
            }
        }
    }
    

}
