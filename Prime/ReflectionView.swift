//
//  ReflectionView.swift
//  Prime
//
//  Created by Ranti Sidauruk on 21/07/22.
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
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		
		//Use this if NavigationBarTitle is with displayMode = .inline
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
	}
	
	var body: some View {
		
		
		NavigationView{
			VStack (spacing:100){
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
						}.padding(.init(top: 25, leading: 20, bottom: 0, trailing: 20))
					)
					.shadow(radius: 3)
					.edgesIgnoringSafeArea(.all)
					.position(x: 195, y: 100)
				
				Image("reflectionBG")
					.resizable()
					.frame(width: 343, height: 499, alignment: .center)
					.scaledToFit()
					//.shadow(radius: 3)
					.edgesIgnoringSafeArea(.all)
					.position(x: 195, y: 10)
					.overlay(
						
					Text("\(taskReflection)")
						.frame(width: 260, height: 300, alignment: .center)
						.background(Color.white)
						.position(x: 175, y: 20)
						.padding(.trailing)
					)
			}
			
			//.navigationBarTitle(Text("Reflection")).navigationBarHidden(false)
			.navigationBarTitle("Reflection", displayMode: .inline)
			.toolbar{
				ToolbarItem(placement: .navigationBarLeading){
					Button("Back"){
						dismiss()
					}
				}
			}
			//			.background(
			//				Image("reflectionBGFull")
			//					.scaledToFit()
			//					.edgesIgnoringSafeArea(.all)
			//
			//			)
		}
	}
}

//struct ReflectionView_Previews: PreviewProvider {
//	static var previews: some View {
//		ReflectionView(taskTitle: "ini contoh", taskTag: "Design", taskPriority: "#1 Do First", taskDate: "")
//	}
//}

func dateToString(taskDeadlineString: Date)->String{
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "E, dd MMM yyyy"
	return dateFormatter.string(from: taskDeadlineString)
	
}


