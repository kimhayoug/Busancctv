//
//  ViewController.swift
//  Busancctv
//
//  Created by D7703_23 on 2018. 11. 19..
//  Copyright © 2018년 D7703_23. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate,UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewcctv.dequeueReusableCell(withIdentifier: "Re", for: indexPath)
        
        let myitems = elements[indexPath.row]
        
        let area = cell.viewWithTag(1) as! UILabel
        let use = cell.viewWithTag(2) as! UILabel
        
        area.text = myitems["area"]
        use.text = myitems["use"]
        
        return cell
    }
    
    @IBOutlet var tableviewcctv: UITableView!
    var elements:[[String:String]] = []
    var items:[String:String] = [:]
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewcctv.delegate = self
        tableviewcctv.dataSource = self
        
        if let path = Bundle.main.url(forResource: "ctv", withExtension: "xml") {
            if let myParser = XMLParser(contentsOf: path) {
                myParser.delegate = self
                
                if myParser.parse() {
                    print("parse succeed!")
                    print(elements)
                } else {
                    print("parse failed!")
                }
            }
        } else {
            print("xml file not found")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        //print(elementName)
        print("currentElement = \(elementName)")
        
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        print("data = \(data)")
        if !data.isEmpty {
            items[currentElement] = data
            //print(item[currentElement])
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "ctv" {
            elements.append(items)
        }
    }


}

