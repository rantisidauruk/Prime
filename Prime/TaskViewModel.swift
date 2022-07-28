//
//  TaskViewModel.swift
//  Prime
//
//  Created by Ranti Sidauruk on 21/07/22.
//


import SwiftUI

class TaskViewModel: ObservableObject{
		
//    //Sample Tasks
//
//    @Published var storedTasks: [Task] = [
//
//        Task(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1641645497)),
//        Task(taskTitle: "Icon Set", taskDescription: "2 Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1641649097)),
//        Task(taskTitle: "Prototype", taskDescription: "3 Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1641652697)),
//        Task(taskTitle: "Check Asset", taskDescription: "4 Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1641656297)),
//        Task(taskTitle: "Team Party", taskDescription: "5 Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1641661897)),
//        Task(taskTitle: "Client Meeting", taskDescription: "6 Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1641641897)),
//        Task(taskTitle: "Next Project", taskDescription: "7 Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1641677897)),
//        Task(taskTitle: "App Proposal", taskDescription: "8 Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1641681497)),
//
//        //Referensi: Google
//        Task(taskTitle: "App Proposal", taskDescription: "8 Discuss team task for the day", taskDate: Date.now),
//        Task(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskDate: Date.now)
//    ]
		
		//MARK: Current Week Days
		@Published var currentWeek: [Date] = []
		
		//MARK: Current Day
		@Published var currentDay: Date = Date()
		
		//MARK: Filtering Today Tasks
		@Published var filteredTasks: [Task]?
		
		//MARK: New Task View
		@Published var addNewTask: Bool = false
		
		//MARK Edit Data
		@Published var editTask: Task?
		
		//MARK Edit Data
		@Published var addReflection: Task?
	
		@Published var filteredArray: [Task] = []
		
		//MARK: Intializing
		init(){
				fetchCurrentWeek()
				//filterTodayTasks()
		}
		
//    //MARK: Filter Today Tasks
//    func filterTodayTasks(){
//        DispatchQueue.global(qos: .userInteractive).async {
//            let calendar = Calendar.current
//            let filtered = self.storedTasks.filter{
//                //return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
//                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
//            }
//
//                .sorted { task1, task2 in
//                    return task2.taskDate < task1.taskDate
//                }
//
//            DispatchQueue.main.async {
//                withAnimation{
//                    self.filteredTasks = filtered
//                }
//            }
//        }
//    }
		
		
		
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
		
		//MARK: Extracting Date
		func extractDate(date: Date, format: String)->String{
				let formatter = DateFormatter()
				
				formatter.dateFormat = format
				
				return formatter.string(from: date)
		}
		
		//MARK: Checking if current date is today
		func isToday(date: Date)->Bool
		{
				let calendar = Calendar.current
				return calendar.isDate(currentDay, inSameDayAs: date)
		}
		
		//MARK: Checking if the currentHour is task Hour
		func isCurrentHour(date: Date)->Bool{
				let calendar = Calendar.current
				
				let hour = calendar.component(.hour, from: date)
				let currentHour = calendar.component(.hour, from: Date())
				
				let isToday = calendar.isDateInToday(date)
				
				return (hour == currentHour && isToday)
		}
}

