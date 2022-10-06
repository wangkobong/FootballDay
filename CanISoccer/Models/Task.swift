//
//  Task.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2022/10/06.
//

import SwiftUI

// Task Model and Sample Task

// Array of Tasks
struct Task: Identifiable {
    var id = UUID()
    var title: String
    var time: Date = Date()
}

// Total Task Meta View
struct TaskMetaData: Identifiable {
    var id = UUID()
    var task: [Task]
    var taskDate: Date
}

// sample Date for Testing
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var tasks: [TaskMetaData] = [
    TaskMetaData(task: [
        Task(title: "과제1-1"),
        Task(title: "과제1-2"),
        Task(title: "과제1-3"),
    ], taskDate: getSampleDate(offset: 1)),
    
    TaskMetaData(task: [
        Task(title: "과제2-1"),
    ], taskDate: getSampleDate(offset: -3)),
    
    TaskMetaData(task: [
        Task(title: "과제3-1"),
    ], taskDate: getSampleDate(offset: -8)),
    
    TaskMetaData(task: [
        Task(title: "과제4-1"),
    ], taskDate: getSampleDate(offset: 10)),
    
    TaskMetaData(task: [
        Task(title: "과제5-1"),
    ], taskDate: getSampleDate(offset: -22)),
    
    TaskMetaData(task: [
        Task(title: "과제6-1"),
    ], taskDate: getSampleDate(offset: 15)),
    
    TaskMetaData(task: [
        Task(title: "과제6-1"),
    ], taskDate: getSampleDate(offset: -20)),
]
