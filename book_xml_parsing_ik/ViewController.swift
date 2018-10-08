//
//  ViewController.swift
//  book_xml_parsing_ik
//
//  Created by k on 헤이세이 30. 10. 7..
//  Copyright © 헤이세이 30년 jik. All rights reserved.
//

import UIKit




class TableViewController: UITableViewController, XMLParserDelegate {
    

    
    var books: [Book] = []
    
    
    
    var eName: String = String()
    
    
    
    var btitle = String()
    
    
    
    var bauthor = String()
    
    
    
    //데이터 객체 초기화
    
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
    
        
        if let path = Bundle.main.url(forResource: "books", withExtension: "xml") {
            
            
            
            if let parser = XMLParser(contentsOf: path) {
                
                
                
                parser.delegate = self
                
                
                
                //파싱 시작
                
                
                
                parser.parse()
                
                
                
                for i in 0 ..< books.count {
                    
            
            
                    print(books[i].btitle)
                    
                    
                }
                
                
                
            } else {
                
                print ("Parsing failed")
                
                
            }
            
            
        }
        
    }
    
    
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
   
        return books.count
   
    }
    
    
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        
     let book = books[indexPath.row]
        
     
        
        cell.textLabel?.text = book.btitle
      
        cell.detailTextLabel?.text = book.bauthor
        
     
        return cell
        
        
        
    }
    
    
 
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        
        
        eName = elementName
      
        
        print("eName = \(eName)")
   
        
        if elementName == "book" {
          
            btitle = ""
            
           bauthor = ""
            
            
   
            
        }
  
    }
    
 
    
    // XMLParserDelegate 메소드 호출
    
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        
        if elementName == "book" {
      
            let book = Book()
            
            
            
            book.btitle = btitle
            
          
            book.bauthor = bauthor
          
            books.append(book)
            
      }
        
       
    }
    
    
    
  
    // <tag>를 만날때
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        
        
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        
        
        //공백 제거
      
        
        if (!data.isEmpty) {
         
            
            if eName == "title" {
                
             
                btitle = data
              
            } else if eName == "author" {
    
                bauthor = data
                
                
            }
            
         
        }
        
        
    }
    
    
    
    
    
    
    
}
