//
//  DynamicFilteredView.swift
//  Prime
//
//  Created by Ranti Sidauruk on 21/07/22.
//

import SwiftUI
import CoreData


struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject{
	@FetchRequest var request: FetchedResults<T>
	let content: (T)->Content
	
	init(dateToFilter: Date,@ViewBuilder content: @escaping (T)->Content){
		
		let calendar = Calendar.current
		let today = calendar.startOfDay(for: dateToFilter)
		let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
		let filterKey = "taskDate"
		let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [today, tomorrow])
		
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
