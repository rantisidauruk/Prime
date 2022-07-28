//
//  Home.swift
//  TaskManagementApp2
//
//  Created by Ranti Sidauruk on 22/07/22.
//

import Foundation
import SwiftUI




struct Home: View {
    
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: false){
            
            
            
            
            
            //MARK: Lazy Stack With Pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                
                Section {
                    
                    //MARK: Current Week View
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing:10){
                            ForEach(taskModel.currentWeek, id: \.self){ day in
                                
                                VStack(spacing: 10){
                                    
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        //.font(.system(size:15))
                                        .font(.system(size:17))
                                        .fontWeight(.semibold)
                                    
                                    
                                    //EEE will return day as MON, TUE, ... etc
                                    //Text(day.formatted(date: .abbreviated, time: .omitted))
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        //.font(.system(size:14))
                                        .font(.system(size:15))
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        //.opacity(taskModel.isToday(date: day) ? 1 : 0)
                                    
                                }
                                //MARK: Foreground Style
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .tertiary)
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                
                                //MARK: Capsule Shape
                                //.frame(width: 40, height: 90)
                                .frame(width: 60, height: 90)
                                
                                .background(
                                    ZStack{
                                        
                                        
                                        //                                        Capsule()
                                        //                                            .fill(.black)
                                        
                                        //MARK: Matched Geometry Effect
                                        if taskModel.isToday(date: day){
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    //Updating Current Day
                                    withAnimation{
                                        taskModel.currentDay = day
                                    }
                                }
                                
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                    
                    TasksView()
                    
                    
                }
                
                //HeaderView()
                
            }
        }.ignoresSafeArea(.container, edges: .top)
        
        //        //MARK: Add Button
        //            .overlay(
        //                Button(action:{
        //                    taskModel.addNewTask.toggle()
        //
        //                }, label:{
        //                    Image(systemName: "plus")
        //                        .foregroundColor(.white)
        //                        .padding()
        //                        .background(Color.black, in: Circle())
        //                })
        //                .padding()
        //
        //                ,alignment: .bottomTrailing
        //            )
        //            .sheet(isPresented: $taskModel.addNewTask){
        //                //Clearing Edit Data
        //                taskModel.editTask = nil
        //            } content: {
        //                NewTask()
        //                    .environmentObject(taskModel)
        //            }
        
        
    }
    

    
    //MARK: Tasks View
    
    
    func TasksView()->some View{
        LazyVStack (spacing: 20){
            
            //Converting object as Our Task Model
            DynamicFilteredView(dateToFilter: taskModel.currentDay) { (object: Task) in
                
                TaskCardView(task: object)
                    
                
                
                
            }
            
            
            


            
//                        if let tasks = taskModel.filteredTasks{
//                            if tasks.isEmpty{
//                                //                    Text("No tasks found!!!")
//                                //                        .font(.system(size:16))
//                                //                        .fontWeight(.light)
//                                //                        .offset(y:100)
//
//
//                            }
//                            else{
//
//                                ForEach(tasks){task in
//                                    TaskCardView(task: task)
//
//
//
//                                }
//                            }
//                        } else {
//                            //MARK: Progress View
//                            ProgressView()
//                                .offset(y: 100)
//                        }
            
//            if let tasks = taskModel.filteredTasks{
//                if tasks.isEmpty{
//                    //                    Text("No tasks found!!!")
//                    //                        .font(.system(size:16))
//                    //                        .fontWeight(.light)
//                    //                        .offset(y:100)
//
//
//                }
//                else{
//
//                    ForEach(tasks){task in
//                        TaskCardView(task: task)
//
//
//
//                    }
//                }
//            } else {
//                //MARK: Progress View
//                ProgressView()
//                    .offset(y: 100)
//            }
            
            
            
            
        }
        .padding()
        //        //MARK: Updating Tasks
        //        .onChange(of: taskModel.currentDay){ newValue in
        //            taskModel.filterTodayTasks()
        //        }
    }
    
    
    //MARK: Task Card View
    func TaskCardView(task: Task)->some View{
        
       
            
            
        //MARK: Since coredata values will give option data
        HStack ( spacing: 30){

  
            //If edit mode enabled then showing delete button
//            if editButton?.wrappedValue == .active{
                
                //Edit Button for current and future tasks
//                VStack(spacing: 10){
//                    if task.taskDate?.compare(Date()) == .orderedDescending || Calendar.current.isDateInToday(task.taskDate ?? Date()){
//                        Button {
//                            taskModel.editTask = task
//                            taskModel.addNewTask.toggle()
//
//                        } label: {
//                            Image(systemName: "pencil.circle.fill")
//                                .font (.title)
//                                .foregroundColor(.primary)
//                        }
//                    }
//
//                    Button {
//                        //MARK: Deleting Task
//                        context.delete(task)
//
//                        //Saving:
//                        try? context.save()
//
//                    } label: {
//                        Image(systemName: "minus.circle.fill")
//                            .font (.title)
//                            .foregroundColor(.red)
//                    }
//                }
                
//            } else {
                //Text(task.taskTitle)
//                VStack(spacing: 10){
//                    Circle()
//                    //.fill(.black)
//                        .fill(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? (task.isCompleted ? .green : .black) : .clear)
//                        .frame(width: 15, height: 15)
//                        .background(
//
//                            Circle()
//                                .stroke(.black, lineWidth: 1)
//                                .padding(-3)
//                        )
//                        .scaleEffect(!taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0.8 : 1)
//
//                    Rectangle()
//                        .fill(.black)
//                        .frame(width: 3)
//
//                }
            //}
            
           
    
    //INI yang LAMA
   
    VStack{
        HStack(alignment: .top, spacing: 10){
            
            VStack(alignment: .leading, spacing: 12){
                Text(task.taskTitle ?? "")
                    .font(.title2.bold())
                
                Text(task.taskDescription ?? "")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                
            }
            .hLeading()
            
            Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "")
        }
        
        if taskModel.isCurrentHour(date: task.taskDate ?? Date()){
            //MARK: Team Members
            
            HStack(spacing:12){
//                        HStack(spacing: -10){
//                            ForEach(["User1", "User2", "User3"], id: \.self){ user in
//                                Image (user)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 45, height: 45)
//                                    .clipShape(Circle())
//                                    .background(
//                                        Circle()
//                                            .stroke(.black, lineWidth: 5)
//                                    )
//                            }
//                        }
//
//                        .hLeading()
                
                
                
                //MARK: Check Button
                if !task.isCompleted{
                    Button{
                        //MARK: Updating Task
                        task.isCompleted = true
                        
                        //Saving
                        try? context.save()
                        
                    }label:{
                        Image(systemName: "checkmark")
                            .foregroundStyle(.black)
                            .padding(10)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10 ))
                    }
                }
                
                Text (task.isCompleted ? "Mark Task as Completed" : "Mark Task as Completed")
                    .font(.system(size: task.isCompleted ? 14 : 16, weight: .light))
                    .foregroundColor(task.isCompleted ? .gray : .white)
                .hLeading()
                
            }
            .padding(.top)
        }
        
    }
    //.foregroundColor((.white))
    .foregroundColor(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? .white : .black)
    //.padding()
    .padding(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 15 : 0)
    .padding(.bottom, taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0 : 10)
    .hLeading()
    .background(
        Color.black
            .cornerRadius(25)
            .opacity(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 1 : 0)
    )
    
}
.hLeading()
}
}


