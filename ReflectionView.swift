//
//  ReflectionFile.swift
//  Prime
//
//  Created by Ranti Sidauruk on 30/07/22.
//

import SwiftUI

struct ReflectionView: View {
	@Environment(\.dismiss) var dismiss
	
	var taskTitle: String
	var taskTag: String
	var taskPriority: String
	var taskDate: Date
	var taskReflection: String
	
	init(taskTitle: String, taskTag: String, taskPriority: String, taskDate: Date, taskReflection: String) {
		self.taskTitle = taskTitle
		self.taskTag = taskTag
		self.taskPriority = taskPriority
		self.taskDate = taskDate
		self.taskReflection = taskReflection
		//Use this if NavigationBarTitle is with Large Font
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
		
		//Use this if NavigationBarTitle is with displayMode = .inline
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange]
		//UINavigationBar.appearance().backgroundColor = UIColor.clear
		
	}
	
	var body: some View {
		
		NavigationView{
			ScrollView(.vertical, showsIndicators: false){
				LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]){
					
					
					Image("QuotesBG")
						.resizable()
						.scaledToFit()
						.overlay(
							VStack(alignment: .leading, spacing: 10){
								HStack{
									Text("\(taskTitle)")
										.font(.custom("Poppins-Regular", size: 17))
										.foregroundColor(Color.white)
									
									Spacer()
									
									Text("\(taskPriority)")
										.font(.custom("Poppins-Regular", size: 16))
										.foregroundColor(Color.white)
								}
								
								Text("\(taskTag)")
									.padding(5)
									.font(.custom("Poppins-Regular", size: 16))
									.foregroundColor(Color("blackCustom"))
									.background(Color("tagBG"))
									.cornerRadius(5)
								
								HStack{
									
									Image(systemName: "calendar.circle.fill")
										.foregroundColor(Color.white)
									
									Text(dateToString(taskDeadlineString:taskDate))
										.font(.custom("Poppins-Regular", size: 16))
										.foregroundColor(Color.white)
								}
							}
								.padding(.init(top: 25, leading: 20, bottom: 0, trailing: 20))
						)
						.shadow(radius: 3)
						.edgesIgnoringSafeArea(.all)
					//.position(x: 195, y: 100)
					
					Spacer()
					
					Image("reflectionBG")
						.resizable()
						.frame(width: 343, height: 499, alignment: .center)
						.scaledToFit()
					//.shadow(radius: 3)
						.edgesIgnoringSafeArea(.all)
					//.position(x: 195, y: 10)
						.overlay(
							Text("\(taskReflection)")
								.frame(width: 260, height: 300, alignment: .center)
								.background(Color.clear)
							//.position(x: 175, y: 20)
								.padding(.init(top: 0, leading: 0, bottom: 0, trailing: 25))
						)
				}
				.navigationBarTitle("Reflection", displayMode: .inline)
				
				.toolbar{
					ToolbarItem(placement: .navigationBarLeading){
						Button("Back"){
							dismiss()
						}
						.foregroundColor(.white)
					}
				}
			}
			.edgesIgnoringSafeArea(.top)}
		
	}
}

func dateToString(taskDeadlineString: Date)->String{
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "E, dd MMM yyyy"
	return dateFormatter.string(from: taskDeadlineString)
	
}


