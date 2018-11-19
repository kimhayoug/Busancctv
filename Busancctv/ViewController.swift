//
//  ViewController.swift
//  Busancctv
//
//  Created by D7703_23 on 2018. 11. 19..
//  Copyright © 2018년 D7703_23. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewcctv.dequeueReusableCell(withIdentifier: "Re", for: indexPath)
        let item1 = item[indexPath.row]
        
        cell.textLabel?.text = item1["area"]
        cell.detailTextLabel?.text = item1["use"]
        
        return cell
    }
    
    @IBOutlet var tableviewcctv: UITableView!
    var item:[[String:String]] = []
    var items:[String:String] = [:]
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewcctv.dataSource = self
        
        if let path = Bundle.main.url(forResource: "ctv", withExtension: "xml") {
            if let myParser = XMLParser(contentsOf: path) {
                myParser.delegate = self
                if myParser.parse() {
                    print("파싱 성공")
                    
                    print("elements = \(items)")
                    
                } else {
                    print("파싱 오류2")
                }
            } else {
                print("파싱 오류1")
            }
        } else {
            print("XML 파일 없음")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        //print(elementName)
        
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            items[currentElement] = data
            //print(item[currentElement])
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "ctv" {
            item.append(items)
        }
    }


}

