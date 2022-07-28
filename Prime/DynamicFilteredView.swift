//
//  PrimeApp.swift
//  Prime
//
//  Created by Ranti Sidauruk on 21/07/22.
//


import SwiftUI
import CoreData


struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject{
	//MARK: Core Data Request
	@FetchRequest var request: FetchedResults<T>
	let content: (T)->Content
	
	//MARK: Building Custom ForEach which will give core data object to build view
	init(dateToFilter: Date,@ViewBuilder content: @escaping (T)->Content){
		
		//MARK: Predicate to Filter current date Tasks
		let calendar = Calendar.current
		
		let today = calendar.startOfDay(for: dateToFilter)
		//let tomorroe = calendar.date(byAdding: .day, value: 1, to: dateToFilter)!
		let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
		
		//Filter Key
		let filterKey = "taskDate"
		let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [today, tomorrow])
		
		//Initializing Request With NSPredicate
		_request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.isCompleted, ascending: true), .init(keyPath: \Task.taskPriority, ascending: true), .init(keyPath: \Task.taskDeadline, ascending: true)], predicate: predicate)
		self.content = content
	}
	
	var body: some View{
		
		Group{
			if request.isEmpty{
				Image("Empty")
					.resizable()
					.scaledToFit()
					.shadow(radius: 1)
					.frame(width: 200, height: 200)
				
				Spacer()
				Text("There's no task to be done yet, \nor have you forgotten something?")
					.font(.system(size:16))
					.font(.custom("Poppins-Regular", size: 16))
					.foregroundColor(Color("blackCustom"))
					.multilineTextAlignment(.center)
				
				
			} else {
				ForEach(request,id: \.objectID){object in
					self.content(object)
				}
				
			}
		}
	}
}
