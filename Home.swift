//
//  Home.swift
//  Prime
//
//  Created by Ranti Sidauruk on 21/07/22.
//


import SwiftUI

struct Home: View {
	@Namespace var animation
	
	@StateObject var taskModel: TaskPlannerViewModel = TaskPlannerViewModel()
	
	@State private var showAlert = false
	@State private var showingSheet = false
	@State private var showingReflection = false
	@State private var isVisible = false
	
	@State var taskReflection: String = ""
	@State var title = ""
	@State var tag = ""
	@State var priority = ""
	@State var date = Date()
	@State var reflection = ""
	
	let taskDeadline = Date()
	
	//MARK: Core Data
	@Environment(\.managedObjectContext) var context
	
	//MARK: Edit Button
	@Environment(\.editMode) var editButton
	@Environment(\.dismiss) var dismiss
	
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false){
			LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]){
				Section{
					VStack (spacing: 25){
						Image("QuotesBG")
							.resizable()
							.scaledToFit()
							.overlay(QuoteText(), alignment: .center)
							.shadow(radius: 3)
							.edgesIgnoringSafeArea(.all)
						
						Text(Date().formatted(date: .abbreviated, time: .omitted))
							.foregroundColor(.gray)
							.padding(.init(top: 0, leading: 0, bottom: 25, trailing: 0))
						
					}
				}
				
				//MARK: Date View
				Section {
					ScrollView(.horizontal, showsIndicators: false) {
						HStack(spacing:10){
							ForEach(taskModel.currentWeek, id: \.self){ day in
								VStack(spacing: 10){
									
									Text(taskModel.extractDate(date: day, format: "dd"))
										.font(.system(size:17))
										.fontWeight(.semibold)
									
									Text(taskModel.extractDate(date: day, format: "EEE"))
										.font(.system(size:15))
									
								}
								.foregroundStyle(taskModel.isToday(date: day) ? .primary : .tertiary)
								.foregroundColor(taskModel.isToday(date: day) ? .white : .black)
								.frame(width: 60, height: 90)
								.background(
									ZStack{
										if taskModel.isToday(date: day){
											RoundedRectangle(cornerRadius: 5)
												.fill(.black)
												.matchedGeometryEffect(id: "CURRENTDAY", in: animation)
										}
									}
								)
								.contentShape(Capsule())
								.onTapGesture {
									withAnimation{
										taskModel.currentDay = day
									}
								}
								
							}
							
						}
						.padding(.horizontal)
					}
				}
				
				//MARK: Plan Card View
				Section{
					HStack(spacing: 20){
						VStack (alignment: .leading, spacing: 10) {
							Text ("Your Plan")
							Divider()
								.frame(height: 2)
								.frame(width: 75)
								.overlay(Color("secondaryColor"))
						}
						.hLeading()
						.overlay(
							Button(action:{
								taskModel.addNewTask.toggle()
								
							}, label:{
								Text("Add")
									.foregroundColor(Color("secondaryColor"))
							})
							.padding()
							,alignment: .bottomTrailing
						)
						.sheet(isPresented: $taskModel.addNewTask){
							//Clearing Edit Data
							taskModel.editTask = nil
						} content: {
							TaskPlanner()
								.environmentObject(taskModel)
						}
						EditButton()
							.padding(.init(top: 0, leading: -20, bottom: 22, trailing: 0))
							.foregroundColor(Color("secondaryColor"))
					}
					.padding()
					.background(Color.white)
					TasksView()
				}
			}
		}
		.ignoresSafeArea(.container, edges: .top)
		.preferredColorScheme(.light)}
	
	
	//MARK: Tasks View
	func TasksView()->some View{
		LazyVStack (spacing: 20){
			DynamicFilteredView(dateToFilter: taskModel.currentDay) { (object: Task) in
				TaskCardView(task: object)
			}
		}
		.padding()
	}
	
	
	//MARK: Task Card View
	func TaskCardView(task: Task)->some View{
		HStack (alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 30){
			
			if editButton?.wrappedValue == .active{
				
				VStack(spacing: 10){
					if task.taskDate?.compare(Date()) == .orderedDescending || Calendar.current.isDateInToday(task.taskDate ?? Date()){
						
						if !task.isCompleted{
							
							Button {
								showAlert = true
								try? context.save()
							} label: {
								Image(systemName: "checkmark.circle.fill")
									.font (.title)
									.foregroundColor(.primary)
							}
							.alert(isPresented: $showAlert) {
								Alert(
									title: Text("I’ve finished the task!"),
									message: Text("Are have sure you have completed this task?"),
									primaryButton: .default(
										Text("Cancel")
									),
									secondaryButton: .destructive(
										Text("Sure")
									) {
										taskModel.editTask = task
										taskModel.addNewTask.toggle()
										//	task.isCompleted = true
									}
								)
							}
							.sheet(isPresented: $showingSheet) {
							}
						}
					}
					
					Button {
						context.delete(task)
						try? context.save()
					} label: {
						Image(systemName: "minus.circle.fill")
							.font (.title)
							.foregroundColor(.red)
					}
				}
			} else {
			}
			
			
			VStack{
				HStack(alignment: .top, spacing: 10){
					VStack(alignment: .leading, spacing: 10){
						Text(task.taskTitle ?? "")
							.font(.custom("Poppins-Regular", size: 16))
							.foregroundColor(Color("blackCustom"))
						
						Text(task.taskTag ?? "")
							.padding(5)
							.font(.custom("Poppins-Regular", size: 15))
							.foregroundColor(Color("blackCustom"))
							.background(Color("tagBG"))
							.cornerRadius(5)
						Text(deadlineToString(taskDeadlineString:task.taskDeadline ?? Date()))
							.font(.custom("Poppins-Regular", size: 16))
							.foregroundColor(Color("blackCustom"))
						
					}
					.hLeading()
					
					VStack(alignment: .trailing, spacing: 10){
						//MARK: Task Priority
						if task.taskPriority == "#1 Do First"{
							Image("priorityOneImage")
						} else if task.taskPriority == "#2 Schedule"{
							Image("priorityTwoImage")
						}else if task.taskPriority == "#3 Delegate"{
							Image("priorityThreeImage")
						}else{
							Image("priorityFourImage")
						}
						
						Text(task.taskDuration ?? "")
							.font(.custom("Poppins-Regular", size: 15))
							.foregroundColor(Color("blackCustom"))
						
						if task.isCompleted == true {
							Text("Completed")
								.font(.custom("Poppins-Regular", size: 16))
								.foregroundColor(Color("OnProgress"))
						} else{
							Text("On Progress")
								.font(.custom("Poppins-Regular", size: 16))
							
								.foregroundColor(Color("Completed"))
						}
					}
				}
			}
			.foregroundColor(Color("blackCustom"))
			.padding().hLeading()
			.background(Color("blackCustom").opacity(0.02).cornerRadius(15))
			.onTapGesture {
				if task.isCompleted == true {
					showingReflection.toggle()
				}
				self.title = task.taskTitle!
				self.tag = task.taskTag!
				self.priority = task.taskPriority!
				self.date = task.taskDate!
				self.reflection = task.taskReflection!
				
			}
			.sheet(isPresented: $showingReflection) {
				ReflectionView(taskTitle: title, taskTag: tag, taskPriority: priority, taskDate: date, taskReflection: reflection)
				//ReflectionView()
			}
			
		}
		.hLeading()
	}
}


struct Home_Previews: PreviewProvider {
	static var previews: some View {
		Home()
	}
}

//MARK: Helper Function
extension View{
	func hLeading()->some View{
		self
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	func hTrailing()->some View{
		self
			.frame(maxWidth: .infinity, alignment: .trailing)
	}
	func hCenter()->some View{
		self
			.frame(maxWidth: .infinity, alignment: .center)
	}
	func getSafeArea()->UIEdgeInsets{
		guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
			return .zero
		}
		guard let safeArea = screen.windows.first?.safeAreaInsets else{
			return .zero
		}
		return safeArea
	}
	
	//MARK:
	func deadlineToString(taskDeadlineString: Date)->String{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "E, dd MMM yyyy"
		return dateFormatter.string(from: taskDeadlineString)
		
	}
	
}

