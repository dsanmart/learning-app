//
//  Models.swift
//  LearningApp
//
//  Created by Diego Sanmartin on 02/11/2021.
//

import Foundation

struct Module: Decodable, Identifiable {
    var id:Int
    var category:String
    var content:Content // This is a Content object
    var test:Test
    
}

struct Content: Decodable, Identifiable {
    var id:Int
    var image:String
    var time:String
    var description:String
    var lessons:[Lessons]
    
}

struct Lessons: Decodable, Identifiable {
    var id:Int
    var title:String
    var video:String
    var duration:String
    var explanation:String
}

struct Test: Decodable, Identifiable {
    var id:Int
    var image:String
    var time:String
    var description:String
    var questions:[Question]
    
}

struct Question: Decodable, Identifiable {
    var id:Int
    var content:String
    var correctindex:Int
    var answers:[String]
}
