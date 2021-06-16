//
//  sqlClass.swift
//  myNews
//
//  Created by 777 on 2021/6/13.
//

import Foundation
import UIKit

class sqlClass
{
    //初始化数据库
    static func initDB()
    {
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB()
        {
            return
        }
        
        let createSql = "CREATE TABLE IF NOT EXISTS news('title' TEXT, 'path' TEXT, 'image' TEXT, 'passtime' TEXT);"
        if !sqlite.execNoneQuerySQL(sql: createSql)
        {
            sqlite.closeDB()
            return
        }

        sqlite.closeDB()
    }
    
    static func loadNews() -> [News]?
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return nil}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM news;")
        //print("query\(queryResult!)")
        
        if queryResult != nil
        {
            var news:[News] = []
            for row in queryResult!
            {
                var a = News(title:"", image:"", path:"", passtime: "")
                a.title = row["title"]! as! String
                a.path = row["path"]! as! String
                a.image = row["image"]! as! String
                a.passtime = row["passtime"]! as! String
                //print(a)
                news.append(a)

            }
            sqlite.closeDB()
            return news
        }
        else
        {
            sqlite.closeDB()
            return nil
        }
    }
    
    static func deleteNews(news:News)
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return}
        if !sqlite.execNoneQuerySQL(sql: "DELETE FROM news WHERE path = '\(news.path)';")
        {
            sqlite.closeDB()
            return
        }
        sqlite.closeDB()
    }
    
    static func addNews(news:News)
    {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB() {return}
        if !sqlite.execNoneQuerySQL(sql: "INSERT INTO news(title,path,image,passtime) VALUES('\(news.title)','\(news.path)','\(news.image)','\(news.passtime)');")
        {
            sqlite.closeDB()
            return
        }
        sqlite.closeDB()
    }
    
}
