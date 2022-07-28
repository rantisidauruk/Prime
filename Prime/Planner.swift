//
//  Planner.swift
//  Prime
//
//  Created by Ranti Sidauruk on 21/07/22.
//


import SwiftUI
import Combine

struct Planner: View {
	//var isEdit: Bool = false
	
	@Environment(\.dismiss) var dismiss
	//MARK: Core Data Context
	@Environment(\.managedObjectContext) var context
	@EnvironmentObject var taskModel: TaskViewModel
	
	@State var taskTitle: String = ""
	@State var taskTag: String = ""
	@State var taskDeadline: Date = Date()
	@State var taskDate: Date = Date()
	@State var taskDuration: String = ""
	@State var taskPriority: String = ""
	@State var taskReflection: String = ""
	@State var isCompleted: Bool = false
	
	@State private var showingSheet = false
	
	let taskTagOption      = ["Design", "Tech", "Business"]
	let taskPriorityOption = ["#1 Do First", "#2 Schedule", "#3 Delegate", "#4 Don't Do"]
	let taskDurationOption = ["15 min", "30 min", "45 min", "1 hr", "1 hr 15 min", "1 hr 30 min", "1 hr 45 min", "2 hr"]
	
	let textLimit = 15
	let dateFormatter = DateFormatter()
	
	init() {
		UITableView.appearance().separatorStyle = .none
		UITableViewCell.appearance().backgroundColor = .white
		UITableView.appearance().backgroundColor = .white
		UINavigationBar.appearance().backgroundColor = .white
	}
	
	var body: some View {
		
		NavigationView {
			List {
				if taskModel.editTask == nil {
					Section{
						TextField("I want to...", text: $taskTitle)
						
					} header: {
						Text ("What do I want to do?").font(Font.custom("Poppins-Regular", size: 14))
					}.listRowBackground(Color("blackCustom").opacity(0.02))
					
					Section{
						Picker("Select Option", selection: $taskTag) {
							ForEach(taskTagOption, id: \.self) {
								Text($0)
							}
						}
					}header: {
						Text ("What expertise?").font(Font.custom("Poppins-Regular", size: 14))
					}.listRowBackground(Color("blackCustom").opacity(0.02))
					
					Section{
						DatePicker("Select Date", selection: $taskDeadline, in: Date()...,  displayedComponents: .date)
					} header: {
						Text ("When is the deadline?").font(Font.custom("Poppins-Regular", size: 14))
					}.listRowBackground(Color("blackCustom").opacity(0.02))
					
					Section{
						DatePicker("Task Date", selection: $taskDate, in: Date()...,  displayedComponents: .date)
					} header: {
						Text ("Kapan mau kelar?").font(Font.custom("Poppins-Regular", size: 14))
					}.listRowBackground(Color("blackCustom").opacity(0.02))
					
					Section{
						Picker("Select Option", selection: $taskDuration) {
							ForEach(taskDurationOption, id: \.self) {
								Text($0)
							}
						}
					}header: {
						Text ("How long will it take to complete?").font(Font.custom("Poppins-Regular", size: 14))
					}.listRowBackground(Color("blackCustom").opacity(0.02))
					
					Section{
						Picker("Select Option", selection: $taskPriority) {
							ForEach(taskPriorityOption, id: \.self) {
								Text($0)
							}
						}
					}header: {
						HStack {
							Text ("At what priority level is this task?").font(Font.custom("Poppins-Regular", size: 14))
							Button {
								showingSheet.toggle()
							}label: {
								Image(systemName: "info.circle.fill")
									.foregroundColor(Color("blackCustom"))
							}
							.sheet(isPresented: $showingSheet) {
								PriorityGuideView()
							}
						}
					}.listRowBackground(Color("blackCustom").opacity(0.02))
					
				}
				
				if (taskModel.editTask != nil) {
					Section{
						TextEditor(text: $taskReflection)
							.onReceive(Just(taskReflection)) { _ in limitText(textLimit) }
					} header: {
						Text ("Any Reflection?").font(Font.custom("Poppins-Regular", size: 14))
					}.listRowBackground(Color("blackCustom").opacity(0.02))
				}
			}
			
			.listStyle(.insetGrouped)
			.navigationTitle("Planner")
			.navigationBarTitleDisplayMode(.inline)
			//MARK: Disbaling Dismiss on Swipe
			.interactiveDismissDisabled()
			//MARK: Action Buttons
			.toolbar{
				ToolbarItem(placement: .navigationBarTrailing){
					
					//					Button("Save"){
					//
					//
					//						//dateFormatter.dateFormat = "YY/MM/dd"
					//						//						dateFormatter.string(from: taskDeadline)
					//
					//						if let task = taskModel.editTask{
					//							//							task.taskTitle = taskTitle
					//							//							task.taskTag = taskTag
					//							//							task.taskDeadline = taskDeadline
					//							//							task.taskDuration = taskDuration
					//							//							task.taskPriority = taskPriority
					//							task.taskReflection = taskReflection
					//
					//
					//							//task.taskDate = taskDate
					//							//						} else if let task = taskModel.addReflection{
					//							//							task.taskTitle = taskTitle
					//							//							task.taskTag = taskTag
					//							//							task.taskDeadline = taskDeadline
					//							//							task.taskDuration = taskDuration
					//							//							task.taskPriority = taskPriority
					//							//							task.taskReflection = taskReflection
					//							//							task.taskDate = taskDate
					//						}
					//						else {
					//							let task = Task(context: context)
					//							task.taskTitle = taskTitle
					//							task.taskTag = taskTag
					//							task.taskDeadline = taskDeadline
					//							task.taskDate = taskDate
					//							task.taskDuration = taskDuration
					//							task.taskPriority = taskPriority
					//							task.taskReflection = taskReflection
					//
					//						}
					//
					//						//Saving
					//
					//						try? context.save()
					//						//Dismissing View
					//						isCompleted = true
					//
					//						//print(dateFormatter.string(from: taskDeadline))
					//						dismiss()
					//
					//					}
					//					.foregroundColor(Color("blackCustom"))
					//					.font(.custom("Poppins-SemiBold", size: 16))
					//.disabled(taskTitle == "" || taskTag == "" || taskDuration == "" || taskPriority == "")
					Button("Save"){
						//dateFormatter.dateFormat = "YY/MM/dd"
						//						dateFormatter.string(from: taskDeadline)
						
						if let task = taskModel.editTask{
							//							task.taskTitle = taskTitle
							//							task.taskTag = taskTag
							//							task.taskDeadline = taskDeadline
							//							task.taskDuration = taskDuration
							//							task.taskPriority = taskPriority
							if taskReflection == "" {
								task.taskReflection = "Oops, you didn't fill in the reflection when you completed this task earlier."
								
							} else {
									task.taskReflection = taskReflection
							}
							
							
							//task.taskDate = taskDate
							//						} else if let task = taskModel.addReflection{
							//							task.taskTitle = taskTitle
							//							task.taskTag = taskTag
							//							task.taskDeadline = taskDeadline
							//							task.taskDuration = taskDuration
							//							task.taskPriority = taskPriority
							//							task.taskReflection = taskReflection
							//							task.taskDate = taskDate
						}
						else {
							let task = Task(context: context)
							task.taskTitle = taskTitle
							task.taskTag = taskTag
							task.taskDeadline = taskDeadline
							task.taskDate = taskDate
							task.taskDuration = taskDuration
							task.taskPriority = taskPriority
							task.taskReflection = taskReflection
							
						}
						
						//Saving
						
						try? context.save()
						//Dismissing View
						isCompleted = true
						
						//print(dateFormatter.string(from: taskDeadline))
						dismiss()
						
						
						//.foregroundColor(Color("blackCustom"))
						
						
					}
					//.disabled(taskTitle == "" || taskTag == "" || taskDuration == "" || taskPriority == "")
					//.padding()
					//.background(Color(red: 0, green: 0, blue: 0.5))
					//.clipShape(Capsule())
					.foregroundColor(Color("secondaryColor"))
					
				}
				
				ToolbarItem(placement: .navigationBarLeading){
					//					Button("Cancel"){
					//						dismiss()
					//					}
					Button {
						dismiss()
					}label: {
						Text("Cancel")
							.foregroundColor(Color("secondaryColor"))
					}
				}
			}
			//Loading task data if from edit
			.onAppear{
				if let task = taskModel.editTask {
					//					taskTitle = task.taskTitle ?? ""
					//					taskTag = task.taskTag ?? ""
					//					taskDeadline = task.taskDeadline ?? Date()
					//					taskDate = task.taskDate ?? Date()
					//					taskDuration = task.taskDuration ?? ""
					//					taskPriority = task.taskPriority ?? ""
					taskReflection = task.taskReflection ?? ""
					
				}
			}
		}
		
		//.background(Color.black.edgesIgnoringSafeArea(.all))
	}
	
	//MARK: Function to Keep Text Length in Limits
	func limitText(_ upper: Int) {
		if taskReflection.count > upper {
			taskReflection = String(taskReflection.prefix(upper))
		}
	}
	
}






