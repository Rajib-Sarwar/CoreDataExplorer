/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import CoreData

class ViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var timesWornLabel: UILabel!
  @IBOutlet weak var lastWornLabel: UILabel!
  @IBOutlet weak var favoriteLabel: UILabel!
  @IBOutlet weak var wearButton: UIButton!
  @IBOutlet weak var rateButton: UIButton!

  // MARK: Proprties
  var managedContext: NSManagedObjectContext!
  
  var currentBowTie: BowTie!
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    managedContext = appDelegate?.persistentContainer.viewContext
    
    insertSampleData()
    
    
    let request = BowTie.fetchRequest()
    
    let firstTitle = segmentedControl.titleForSegment(at: 0) ?? ""
    request.predicate = NSPredicate(
      format: "%K = %@",
      argumentArray: [#keyPath(BowTie.searchKey), firstTitle]
    )
    
    do {
      let result = try managedContext.fetch(request)
      if let tie = result.first {
        populate(bowtie: tie)
        currentBowTie = tie
      }
    } catch let error as NSError {
      print("Could not fetch, \(error.userInfo)")
    }
  }

  // MARK: - IBActions

  @IBAction func segmentedControl(_ sender: UISegmentedControl) {
    // Add code here
    guard let selectedValue = sender.titleForSegment(at: sender.selectedSegmentIndex) else {
      return
    }
    
    let request: NSFetchRequest<BowTie> = BowTie.fetchRequest()
    request.predicate = NSPredicate(
      format: "%K = %@",
      argumentArray: [#keyPath(BowTie.searchKey), selectedValue])
    
    do {
      let result = try managedContext.fetch(request)
      currentBowTie = result.first
      populate(bowtie: currentBowTie)
    } catch let error as NSError {
      print("Failed to fetch, \(error.userInfo)")
    }
  }

  @IBAction func wear(_ sender: UIButton) {
    // Add code here
    currentBowTie.timesWorn += 1
    currentBowTie.lastWorn = Date()
    
    do {
      try managedContext.save()
      populate(bowtie: currentBowTie)
    } catch let error as NSError {
      print("Couldn't fetch, \(error.userInfo)")
    }
  }

  @IBAction func rate(_ sender: UIButton) {
    // Add code here
    let alert = UIAlertController(title: "New Rating",
                                    message: "Rate this bow tie",
                                    preferredStyle: .alert)

      alert.addTextField { textField in
        textField.keyboardType = .decimalPad
      }

      let cancelAction = UIAlertAction(title: "Cancel",
                                       style: .cancel)

      let saveAction = UIAlertAction(
        title: "Save",
        style: .default
        ) { [unowned self] _ in
          if let textField = alert.textFields?.first {
            self.update(rating: textField.text)
          }
        }

      alert.addAction(cancelAction)
      alert.addAction(saveAction)
      
      present(alert, animated: true)
  }
  
  func update(rating: String?) {

    guard let ratingString = rating,
      let rating = Double(ratingString) else {
        return
    }

    do {
      currentBowTie.rating = rating
      try managedContext.save()
      populate(bowtie: currentBowTie)
    } catch let error as NSError {
      if error.domain == NSCocoaErrorDomain &&
            (error.code == NSValidationNumberTooLargeError ||
              error.code == NSValidationNumberTooSmallError) {
            rate(rateButton)
          } else {
            print("Could not save \(error), \(error.userInfo)")
          }
    }
  }
  
  func insertSampleData() {
    let fetch: NSFetchRequest<BowTie> =  BowTie.fetchRequest()
    fetch.predicate = NSPredicate(format: "searchKey != nil")
    
    let tieCounts = (try? managedContext.count(for: fetch)) ?? 0
    
    if tieCounts > 0 {
      // SampleData.plist data already in Core Data
      return
    }
    
    let path = Bundle.main.path(forResource: "SampleData", ofType: "plist")
    let dataArray = NSArray(contentsOfFile: path!)!
    
    for dict in dataArray {
      let entity = NSEntityDescription.entity(forEntityName: "BowTie", in: managedContext)!
      let bowTie = BowTie(entity: entity, insertInto: managedContext)
      
      let btDict = dict as! [String: Any]
      
      bowTie.id = UUID(uuidString: btDict["id"] as! String)
      bowTie.name = btDict["name"] as? String
      bowTie.searchKey = btDict["searchKey"] as? String
      bowTie.rating = btDict["rating"] as! Double
      let colorDict = btDict["tintColor"] as! [String: Any]
      bowTie.tintColor = UIColor.color(dict: colorDict)
      
      let imageName = btDict["imageName"] as? String
      let image = UIImage(named: imageName!)
      bowTie.photoData = image?.pngData()
      bowTie.lastWorn = btDict["lastWorn"] as? Date
      
      let timesNumber = btDict["timesWorn"] as! NSNumber
      bowTie.timesWorn = timesNumber.int32Value
      bowTie.isFavourite = btDict["isFavorite"] as! Bool
      bowTie.url = URL(string: btDict["url"] as! String)
    }
    
    try? managedContext.save()
  }
  
  private func populate(bowtie: BowTie) {
    guard let imageData = bowtie.photoData as Data?,
        let lastWorn = bowtie.lastWorn as Date?,
        let tintColor = bowtie.tintColor else {
          return
      }
    imageView.image = UIImage(data: imageData)
    nameLabel.text = bowtie.name
    ratingLabel.text = "Rating: \(bowtie.rating)/5"
    
    timesWornLabel.text = "# times worn: \(bowtie.timesWorn)"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    
    lastWornLabel.text = "Last worn: " + dateFormatter.string(from: lastWorn)
    favoriteLabel.isHidden = !bowtie.isFavourite
    view.tintColor = tintColor
  }
}

private extension UIColor {
  static func color(dict: [String: Any]) -> UIColor? {
    guard
      let red = dict["red"] as? NSNumber,
      let green = dict["green"] as? NSNumber,
      let blue = dict["blue"] as? NSNumber else {
      return nil
    }
    
    return UIColor(
      red: CGFloat(truncating: red) / 255.0,
      green: CGFloat(truncating: green) / 255.0,
      blue: CGFloat(truncating: blue) / 255.0,
      alpha: 1)
  }
  
}
