//
//  TaskPlannerViewModel.swift
//  Prime
//
//  Created by Ranti Sidauruk on 21/07/22.
//

import SwiftUI

class TaskPlannerViewModel: ObservableObject{
	
	@Published var currentWeek: [Date] = []
	@Published var currentDay: Date = Date()
	@Published var filteredTasks: [Task]?
	@Published var addNewTask: Bool = false
	@Published var editTask: Task?
	@Published var addReflection: Task?
	@Published var filteredArray: [Task] = []
	
	init(){
		fetchCurrentWeek()
	}
	
	func fetchCurrentWeek(){
		let today = Date()
		let calendar = Calendar.current
		let week = calendar.dateInterval(of: .weekOfMonth, for: today)
		
		guard let firstWeekDay = week?.start else{
			return
		}
		
		(1...7).forEach { day in
			if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
				currentWeek.append(weekday)
			}
		}
	}
	
	
	func extractDate(date: Date, format: String)->String{
		let formatter = DateFormatter()
		
		formatter.dateFormat = format
		
		return formatter.string(from: date)
	}
	
	
	func isToday(date: Date)->Bool
	{
	let calendar = Calendar.current
	return calendar.isDate(currentDay, inSameDayAs: date)
	}
	
	
	func isCurrentHour(date: Date)->Bool{
		let calendar = Calendar.current
		let hour = calendar.component(.hour, from: date)
		let currentHour = calendar.component(.hour, from: Date())
		let isToday = calendar.isDateInToday(date)
		return (hour == currentHour && isToday)
	}
}

