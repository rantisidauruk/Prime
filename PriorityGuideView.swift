//
//  PriorityGuideView.swift
//  Prime
//
//  Created by Ranti Sidauruk on 21/07/22.
//

import SwiftUI

struct PriorityGuideView: View{
	
	@Environment(\.dismiss) var dismiss
	
	init() {
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
	}
	
	var body: some View{
		NavigationView{
			VStack(spacing: -10){
				RoundedRectangle(cornerRadius: 5).fill(Color("priorityOneBG"))
					.frame(width: 345, height: 100)
					.padding(16)
					.overlay(
						VStack{
							HStack(spacing:10){
								Image("priorityOne")
								Text("#1 Do First")
									.font(.custom("Poppins-Regular", size: 16))
									.textCase(nil)
									.foregroundColor(Color("priorityOneColor"))
							}
							
							Text ("Do this task first if it is urgent and important.")
								.multilineTextAlignment(.center)
								.textCase(nil)
								.font(.custom("Poppins-Regular", size: 16))
								.foregroundColor(Color("blackCustom"))
								.frame(width: 310, alignment: .center)
						}
					)
				
				RoundedRectangle(cornerRadius: 5).fill(Color("priorityTwoBG"))
					.frame(width: 345, height: 100)
					.padding(16)
					.overlay(
						VStack{
							HStack(spacing:10){
								Image("priorityTwo")
								
								Text("#2 Schedule")
									.font(.custom("Poppins-Regular", size: 16))
									.textCase(nil)
									.foregroundColor(Color("priorityTwoColor"))
							}
							
							Text ("Schedule this task if it is important but not urgent.")
								.multilineTextAlignment(.center)
								.textCase(nil)
								.font(.custom("Poppins-Regular", size: 16))
								.foregroundColor(Color("blackCustom"))
								.frame(width: 310, alignment: .center)
						}
					)
				
				RoundedRectangle(cornerRadius: 5).fill(Color("priorityThreeBG"))
					.frame(width: 345, height: 100)
					.padding(16)
					.overlay(
						VStack{
							HStack(spacing:10){
								Image("priorityThree")
								
								Text("#3 Delegate")
									.font(.custom("Poppins-Regular", size: 16))
									.textCase(nil)
									.foregroundColor(Color("priorityThreeColor"))
							}
							
							Text ("Delegate this task if it is urgent but not important.")
								.multilineTextAlignment(.center)
								.textCase(nil)
								.font(.custom("Poppins-Regular", size: 16))
								.foregroundColor(Color("blackCustom"))
								.frame(width: 310, alignment: .center)
						}
					)
				
				RoundedRectangle(cornerRadius: 5).fill(Color("priorityFourBG"))
					.frame(width: 345, height: 100)
					.padding(16)
					.overlay(
						VStack{
							HStack(spacing:10){
								Image("priorityFour")
								
								Text("#4 Don’t Do")
									.font(.custom("Poppins-Regular", size: 16))
									.textCase(nil)
									.foregroundColor(Color("priorityFourColor"))
							}
							
							Text ("Do not do this task if it is not urgent and not important.")
								.multilineTextAlignment(.center)
								.textCase(nil)
								.font(.custom("Poppins-Regular", size: 16))
								.foregroundColor(Color("blackCustom"))
								.frame(width: 310, alignment: .center)
						}
					)
			}
			.padding(.init(top: -150, leading: 0, bottom: 0, trailing: 0))
			.toolbar{
				ToolbarItem(placement: .navigationBarLeading){
					Button("Back"){
						dismiss()
					}
				}
			}
			.navigationBarTitle(Text("Priority Guide")).navigationBarHidden(false)
			.navigationBarTitle("", displayMode: .inline)
		}
	}
}

struct PriorityGuideView_Previews: PreviewProvider {
	static var previews: some View {
		PriorityGuideView()
	}
}
