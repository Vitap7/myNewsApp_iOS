//
//  JSONFileManager.swift
//  myNews
//
//  Created by 777 on 2021/6/7.
//

import Foundation

class JsonFileManager<T:NSObject&Codable>
{
    var Records:[T] = []
    
    var Url:URL
    
    init(filename: String)
    {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        Url = path.appendingPathComponent(filename)
        
        print(Url.path)
    }
    
    // MARK: Models encode and save to file
    
    func Save()
    {
        let encoder = JSONEncoder()
        
        do
        {
            let encodeData: Data? = try encoder.encode(Records)
            try encodeData!.write(to: Url, options: .atomic)
        }
        catch
        {
            print(error)
        }
    }
    
    // MARK: Load from file and decode to Models
    func Load()
    {
        do
        {
            if let encodeData = try? Data.init(contentsOf: Url)
            {
                let decoder = JSONDecoder()
                Records = try decoder.decode([News].self, from: encodeData) as! [T]
            }
        }
        catch
        {
            print(error)
        }
    }
    
}
